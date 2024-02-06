import 'package:flutter/material.dart';
import '/models/dice.dart';
import '/models/scorecard.dart';
import 'dice_display.dart';
import 'score_display.dart';

class Yahtzee extends StatefulWidget {
  const Yahtzee({super.key});

  @override
  State<Yahtzee> createState() {
    return _YahtzeeState();
  }
}

class _YahtzeeState extends State<Yahtzee> {
  late Dice dice;
  late ScoreCard scoreCard;
  int rollsLeft = 3;

  @override
  void initState() {
    super.initState();
    dice = Dice(5);
    dice.roll();
    scoreCard = ScoreCard();
  }

  List<ScoreCategory> leftCategories = [
    ScoreCategory.ones,
    ScoreCategory.twos,
    ScoreCategory.threes,
    ScoreCategory.fours,
    ScoreCategory.fives,
    ScoreCategory.sixes,
  ];

  List<ScoreCategory> rightCategories = [
    ScoreCategory.threeOfAKind,
    ScoreCategory.fourOfAKind,
    ScoreCategory.fullHouse,
    ScoreCategory.smallStraight,
    ScoreCategory.largeStraight,
    ScoreCategory.yahtzee,
    ScoreCategory.chance,
  ];

  void toggleHold(int index) {
    setState(() {
      if (rollsLeft < 3) {
        dice.toggleHold(index);
      }
    });
  }

  void _handleScoreCategory(ScoreCategory category) {
    if (rollsLeft < 3 && !scoreCard.isCategoryScored(category)) {
      setState(() {
        scoreCard.registerScore(category, dice.values);
        rollsLeft = 3;
        dice.holdClear();
        //dice.valuesClear();
      });

      if (scoreCard.completed) {
        // Alert Dialog box as mentioned in the requirements to reset the game
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Game Over!'),
              content: Text('Your final score is ${scoreCard.total}'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Try Again'),
                  onPressed: () {
                    setState(() {
                      scoreCard.clear();
                      //dice.clear();
                      dice.holdClear();
                      rollsLeft = 3;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('lib/assets/dice_background1.jpg'),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.75),
            BlendMode.darken,
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 7, 1, 46),
          title: const Text('The Yahtzee Game'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              DiceDisplay(
                dice: dice,
                diceValues: dice.values,
                heldDice: dice.held,
                onHoldToggle: toggleHold,
                rollsLeft: rollsLeft,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: rollsLeft > 0
                    ? () {
                        setState(() {
                          if (rollsLeft > 0) {
                            dice.roll();
                            rollsLeft--;
                          }
                        });
                      }
                    : null,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 7, 1, 46)),
                ),
                child: Text('Roll Dice ($rollsLeft)'),
              ),
              ScoreCardDisplay(
                scoreCard: scoreCard,
                onCategorySelected: _handleScoreCategory,
                leftCategories: leftCategories,
                rightCategories: rightCategories,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
