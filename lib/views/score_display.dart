import 'package:flutter/material.dart';
import '/models/scorecard.dart';

class ScoreCardDisplay extends StatelessWidget {
  final ScoreCard scoreCard;
  final Function(ScoreCategory) onCategorySelected;
  final List<ScoreCategory> leftCategories;
  final List<ScoreCategory> rightCategories;

  const ScoreCardDisplay({
    required this.scoreCard,
    required this.onCategorySelected,
    required this.leftCategories,
    required this.rightCategories,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 13),
          child: const Text(
            'SCOREBOARD',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  for (var index = 0; index < leftCategories.length; index++)
                    Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ElevatedButton(
                        onPressed: scoreCard[leftCategories[index]] == null
                            ? () => onCategorySelected(leftCategories[index])
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 7, 1, 46),
                          textStyle: const TextStyle(color: Colors.black),
                        ),
                        child: Text(
                          '${leftCategories[index].name}: ${scoreCard[leftCategories[index]] ?? ''}',
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 150,
              height: 50,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 232, 227, 177),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  'Score: ${scoreCard.total}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 7, 4, 47),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  for (var index = 0; index < rightCategories.length; index++)
                    Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ElevatedButton(
                            onPressed: scoreCard[rightCategories[index]] == null
                                ? () =>
                                    onCategorySelected(rightCategories[index])
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 7, 1, 46),
                              textStyle: const TextStyle(color: Colors.black),
                            ),
                            child: Text(
                              '${rightCategories[index].name}: ${scoreCard[rightCategories[index]] ?? ''}',
                            ))),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
