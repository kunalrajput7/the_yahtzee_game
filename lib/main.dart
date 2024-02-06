import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mp2/models/dice.dart';
import 'package:mp2/models/scorecard.dart';
import 'package:mp2/views/yahtzee.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ScoreCard>(create: (context) => ScoreCard()),
        Provider<Dice>(create: (context) => Dice(5)),
      ],
      child: const MaterialApp(
        title: 'YAHTZEE GAME',
        home: Scaffold(
          body: Yahtzee(),
        ),
      ),
    ),
  );
}
