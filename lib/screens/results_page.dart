import 'package:daiet/constants.dart';
import 'package:daiet/components/reusable_card.dart';
import 'package:flutter/material.dart';
import '../components/bottom_button.dart';
import 'calories_page.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'daily_page.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({required this.bmiResult, required this.resultText, required this.interpretation, required this.caloriesResult});

  final String bmiResult;
  final String resultText;
  final String interpretation;
  final int caloriesResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI RESULTS')
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Container(
            padding: EdgeInsets.all(15.0),
            alignment: Alignment.bottomLeft,
            child: AutoSizeText('Your Results', style: kTitleTextStyle,),
          )),
          Expanded(
            flex: 5,
            child: ReusableCard(
              color: kActiveCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AutoSizeText(
                    resultText.toUpperCase(),
                    style: kResultTextStyle,
                  ),
                  AutoSizeText(
                    'BMI: ' + bmiResult,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                  AutoSizeText(
                    'Recommended Calorie Intake:\n' + caloriesResult.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  AutoSizeText(
                    interpretation,
                    textAlign: TextAlign.center,
                    style: kBodyTextStyle,
                  ),
                ],
              ),
            ),
          ),
          BottomButton(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DailyPage(
                    caloriesResult: caloriesResult
                  )
                ),
              );
            },
            buttonTitle: 'NEXT',
          ),
        ],
      ),
    );
  }
}
