import 'package:flutter/material.dart';
import 'dart:math';

enum ExerciseLevel { little, moderate, active }
enum Gender { male, female }

class CalculatorBrain {

  CalculatorBrain({required this.height, required this.weight, required this.gender, required this.exerciseLevel});

  final int height; // cm
  final int weight; // kg
  final Gender gender;
  final ExerciseLevel exerciseLevel;

  late double _bmi;

  String calculateBMI() {
    _bmi = weight / pow(height * 0.01, 2);
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi >= 25) return 'Overweight';
    else if (_bmi > 18.5) return 'Normal';
    return 'Underweight';
  }

  String getInterpretation() {
    if (_bmi >= 25) return 'You have a higher than normal body weight.';
    else if (_bmi > 18.5) return 'You have a normal body weight.';
    return 'You have a lower than normal body weight.';
  }

  int getCalories() {
    // Base daily calorie intake calculation on BMI
    // These values can be adjusted based on more detailed research or specific dietary needs
    int baseCalories = gender == Gender.male ? (_bmi * 88).round() : (_bmi * 78).round();

    if (exerciseLevel == ExerciseLevel.little) {
      return (baseCalories * 1.2).round(); // Sedentary
    } else if (exerciseLevel == ExerciseLevel.moderate) {
      return (baseCalories * 1.55).round(); // Moderately active
    } else if (exerciseLevel == ExerciseLevel.active) {
      return (baseCalories * 1.9).round(); // Very active
    }
    return baseCalories.round();
  }
}