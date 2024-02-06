import 'package:flutter/material.dart';
import 'package:mp2/models/dice.dart';

class DiceDisplay extends StatelessWidget {
  final Dice dice;
  final List<int?> diceValues;
  final List<bool> heldDice;
  final Function(int) onHoldToggle;
  final int rollsLeft;

  const DiceDisplay({
    required this.dice,
    required this.diceValues,
    required this.heldDice,
    required this.onHoldToggle,
    required this.rollsLeft,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < 5; i++)
          GestureDetector(
            onTap: () {
              if (diceValues[i] != null) {
                onHoldToggle(i);
              }
            },
            child: Container(
              width: 60,
              height: 60,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: heldDice[i]
                    ? const Color.fromARGB(255, 232, 227, 177)
                    : Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
              child: Center(
                child: Text(
                  //diceValues[i]?.toString() ?? '',
                  rollsLeft == 3 ? ' ' : (diceValues[i]?.toString() ?? ' '),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
