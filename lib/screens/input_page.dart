import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/custom_icon_card.dart';
import '../components/reusable_card.dart';
import '../constants.dart';
import 'results_page.dart';
import '../components/bottom_button.dart';
import '../components/round_icon_button.dart';
import 'package:daiet/calculator_brain.dart';
import 'package:auto_size_text/auto_size_text.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  int height = 180; // cm
  int weight = 60; // kg
  int age = 20; // age

  Color maleCardColor = kActiveCardColor;
  Color femaleCardColor = kInactiveCardColor;

  Color littleCardColor = kActiveCardColor;
  Color moderateCardColor = kInactiveCardColor;
  Color activeCardColor = kInactiveCardColor;

  late Gender selectedGender = Gender.male;
  late ExerciseLevel selectedExerciseLevel = ExerciseLevel.little;

  void updateExerciseColour(ExerciseLevel selectedExerciseLevel) {
    if (selectedExerciseLevel == ExerciseLevel.little) {
      littleCardColor = (littleCardColor == kInactiveCardColor)
          ? kActiveCardColor
          : kInactiveCardColor;
      moderateCardColor = (moderateCardColor == kActiveCardColor)
          ? kInactiveCardColor
          : moderateCardColor;
      activeCardColor = (activeCardColor == kActiveCardColor)
          ? kInactiveCardColor
          : activeCardColor;
    } else if (selectedExerciseLevel == ExerciseLevel.moderate) {
      littleCardColor = (littleCardColor == kActiveCardColor)
          ? kInactiveCardColor
          : littleCardColor;
      moderateCardColor = (moderateCardColor == kInactiveCardColor)
          ? kActiveCardColor
          : kInactiveCardColor;
      activeCardColor = (activeCardColor == kActiveCardColor)
          ? kInactiveCardColor
          : activeCardColor;
    } else if (selectedExerciseLevel == ExerciseLevel.active) {
      littleCardColor = (littleCardColor == kActiveCardColor)
          ? kInactiveCardColor
          : littleCardColor;
      moderateCardColor = (moderateCardColor == kActiveCardColor)
          ? kInactiveCardColor
          : moderateCardColor;
      activeCardColor = (activeCardColor == kInactiveCardColor)
          ? kActiveCardColor
          : kInactiveCardColor;
    }
    this.selectedExerciseLevel = selectedExerciseLevel;
  }

    void updateGenderColour(Gender selectedGender) {
      if (selectedGender == Gender.male) {
        maleCardColor = (maleCardColor == kInactiveCardColor)
            ? kActiveCardColor
            : kInactiveCardColor;
        femaleCardColor = (maleCardColor == kActiveCardColor)
            ? kInactiveCardColor
            : femaleCardColor;
      } else if (selectedGender == Gender.female) {
        femaleCardColor = (femaleCardColor == kInactiveCardColor)
            ? kActiveCardColor
            : kInactiveCardColor;
        maleCardColor = (femaleCardColor == kActiveCardColor)
            ? kInactiveCardColor
            : maleCardColor;
      }
      this.selectedGender = selectedGender;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('CALORIE CALCULATOR'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ReusableCard(
                        onPress: () {
                          setState(() {
                            updateGenderColour(Gender.male);
                          });
                        },
                        color: maleCardColor,
                        cardChild: CustomIconCard(
                            icon: FontAwesomeIcons.mars, text: 'MALE')),
                  ),
                  Expanded(
                    child: ReusableCard(
                        onPress: () {
                          setState(() {
                            updateGenderColour(Gender.female);
                          });
                        },
                        color: femaleCardColor,
                        cardChild: CustomIconCard(
                            icon: FontAwesomeIcons.venus, text: 'FEMALE')),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ReusableCard(
                color: kActiveCardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText('HEIGHT', style: kLabelTextStyle),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        AutoSizeText(
                          height.toString(),
                          style: kNumberTextStyle,
                        ),
                        AutoSizeText(
                          'cm',
                          style: kLabelTextStyle,
                        )
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: Color(0xFF4C3F5E),
                        thumbColor: Color(0xFF7CB69D),
                        overlayColor: Color(0x296CBDE9),
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 15.0,
                        ),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 30.0),
                      ),
                      child: Slider(
                        value: height.toDouble(),
                        min: 120.0,
                        max: 220.0,
                        onChanged: (double newValue) {
                          setState(() {
                            height = newValue.round();
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ReusableCard(
                      color: kActiveCardColor,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText('WEIGHT', style: kLabelTextStyle),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                AutoSizeText(weight.toString(), style: kNumberTextStyle),
                                AutoSizeText('kg', style: kLabelTextStyle),
                              ],
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    if (weight > 0) {
                                      weight--;
                                    }
                                  });
                                },
                              ),
                              SizedBox(width: 10.0),
                              RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    if (weight < 500) {
                                      weight++;
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      color: kActiveCardColor,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText('AGE', style: kLabelTextStyle),
                          AutoSizeText(age.toString(), style: kNumberTextStyle),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    if (age > 0) {
                                      age--;
                                    }
                                  });
                                },
                              ),
                              SizedBox(width: 10.0),
                              RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    if (age < 120) {
                                      age++;
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ReusableCard(
                        onPress: () {
                          setState(() {
                            updateExerciseColour(ExerciseLevel.little);
                          });
                        },
                        color: littleCardColor,
                        cardChild: CustomIconCard(
                            icon: FontAwesomeIcons.person, text: 'Sedentary')),
                  ),
                  Expanded(
                    child: ReusableCard(
                        onPress: () {
                          setState(() {
                            updateExerciseColour(ExerciseLevel.moderate);
                          });
                        },
                        color: moderateCardColor,
                        cardChild: CustomIconCard(
                            icon: FontAwesomeIcons.personWalking, text: 'Moderately Active')),
                  ),
                  Expanded(
                    child: ReusableCard(
                        onPress: () {
                          setState(() {
                            updateExerciseColour(ExerciseLevel.active);
                          });
                        },
                        color: activeCardColor,
                        cardChild: CustomIconCard(
                            icon: FontAwesomeIcons.personRunning, text: 'Very Active')),
                  ),
                ],
              ),
            ),
            BottomButton(
                onTap: () {

                  CalculatorBrain calc = CalculatorBrain(
                    height: height,
                    weight: weight,
                    gender: selectedGender,
                    exerciseLevel: selectedExerciseLevel,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultsPage(
                        bmiResult: calc.calculateBMI(),
                        resultText: calc.getResult(),
                        interpretation: calc.getInterpretation(),
                        caloriesResult: calc.getCalories(),
                      ),
                    ),
                  );
                },
                buttonTitle: 'CALCULATE')
          ],
        ));
  }
}
