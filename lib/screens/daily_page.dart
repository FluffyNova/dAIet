import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:daiet/components/reusable_card.dart';
import 'package:daiet/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:daiet/screens/ai.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class DailyPage extends StatefulWidget {
  const DailyPage({required this.caloriesResult, super.key});

  final int caloriesResult;

  @override
  _DailyPageState createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  late num totalCalories = widget.caloriesResult; // Use passed caloriesResult
  List<Map<String, dynamic>> meals = [];
  List<Map<String, dynamic>> exercises = []; // Added for exercise logging
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _textEditingController1 = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _exerciseController = TextEditingController(); // For logging exercise
  Color buttonColor = Colors.blue;
  bool canButtonPress = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    totalCalories = widget.caloriesResult;
    focusNode.addListener(() {
      setState(() {
        if(_caloriesController.text.isNotEmpty && int.tryParse(_caloriesController.text) != null) {
          buttonColor = Colors.blue;
          canButtonPress = true;
        } else {
          buttonColor = Colors.black38;
          canButtonPress = false;
        }
      });
    });
  }

  void _updateButtonState() {
    setState(() {
      canButtonPress = _caloriesController.text.isNotEmpty && int.tryParse(_caloriesController.text) != null;
      buttonColor = canButtonPress ? Colors.blue : Colors.black38;
    });
  }

  void _addMeal() {
    String mealName = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Meal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _textEditingController,
                onChanged: (value) => mealName = value,
                decoration: InputDecoration(hintText: "Meal Name"),
              ),
              TextField(
                controller: _caloriesController,
                keyboardType: TextInputType.numberWithOptions(decimal: false),
                decoration: InputDecoration(hintText: "Calories"),
                focusNode: focusNode,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Add', style: TextStyle(color: buttonColor),),
              onPressed: () {
                setState(() {
                  if(_textEditingController.text.isNotEmpty && _caloriesController.text.isNotEmpty && int.tryParse(_caloriesController.text) != null) {
                    totalCalories -= int.parse(_caloriesController.text);
                    meals.add({'name': mealName, 'calories': int.parse(_caloriesController.text)});
                    _textEditingController.clear();
                    _caloriesController.clear(); // Clear the input field after adding a meal
                    Navigator.of(context).pop();
                  }
                });
              }
            ),
          ],
        );
      },
    );
  }

  void _deleteMeal(int index) {
    setState(() {
      totalCalories += meals[index]['calories']; // Add back the calories of the deleted meal
      meals.removeAt(index); // Remove the meal from the list
    });
  }

  void _addExercise() {
    String exerciseName = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Exercise'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _textEditingController1,
                onChanged: (value) => exerciseName = value,
                decoration: InputDecoration(hintText: "Exercise Name"),
              ),
              TextField(
                controller: _caloriesController,
                keyboardType: TextInputType.numberWithOptions(decimal: false),
                decoration: InputDecoration(hintText: "Calories"),
                focusNode: focusNode,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
                child: Text('Add', style: TextStyle(color: buttonColor),),
                onPressed: () {
                  setState(() {
                    if(_textEditingController1.text.isNotEmpty && _caloriesController.text.isNotEmpty && int.tryParse(_caloriesController.text) != null) {
                      totalCalories += int.parse(_caloriesController.text);
                      exercises.add({'name': exerciseName, 'calories': int.parse(_caloriesController.text)});
                      _textEditingController1.clear();
                      _caloriesController.clear(); // Clear the input field after adding a meal
                      Navigator.of(context).pop();
                    }
                  });
                }
            ),
          ],
        );
      },
    );
  }

  void _deleteExercise(int index) {
    setState(() {
      totalCalories -= meals[index]['calories']; // Add back the calories of the deleted meal
      exercises.removeAt(index); // Remove the meal from the list
    });
  }

  // Floating Action Button to access AI chat assistant
  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AIPage()
          ),
        );
      },
      child: Icon(
        FontAwesomeIcons.robot
      ),
      backgroundColor: Colors.green,
    );
  }

  void _retrieveAndAddRecipe() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? savedRecipeJson = prefs.getString('savedRecipe');

    if (savedRecipeJson != null) {
      // Assuming savedRecipeJson is a simple JSON with 'name' and 'calories'
      final String savedRecipe = savedRecipeJson;
      final int recipeCalories = 250;

      setState(() {
        totalCalories -= recipeCalories; // Adjust based on whether you want to add or subtract calories
        meals.add({'name': 'Retrieved Meal', 'calories': recipeCalories});
      });
    } else {
      // Handle the case where there is no saved recipe
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No saved recipe found.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Intake'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: Text(
              'Calories left: $totalCalories',
              style: TextStyle(fontSize: 24, color: totalCalories >= 0 ? Colors.green : Colors.red),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Long press to delete meal/exercise!',
              style: TextStyle(fontSize: 14, color: Colors.white54),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                return ReusableCard(
                  color: Color(0xFF99746F),
                  cardChild: ListTile(
                    title: Text(meals[index]['name'], overflow: TextOverflow.ellipsis,),
                    trailing: Text("${meals[index]['calories']} calories", overflow: TextOverflow.ellipsis,),
                    onLongPress: () => _deleteMeal(index), // Enable meal deletion on long press
                  ),
                  onPress: () {},
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                return ReusableCard(
                  color: Color(0xFF4d6b53),
                  cardChild: ListTile(
                    title: Text(exercises[index]['name'], overflow: TextOverflow.ellipsis,),
                    trailing: Text("${exercises[index]['calories']} calories", overflow: TextOverflow.ellipsis,),
                    onLongPress: () => _deleteExercise(index), // Enable meal deletion on long press
                  ),
                  onPress: () {},
                );
              },
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ReusableCard(
                  color: kActiveCardColor,
                  cardChild: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Add Meal',
                      style: TextStyle(fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  onPress: _addMeal,
                ),
                ReusableCard(
                  color: kActiveCardColor,
                  cardChild: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Add Exercise',
                      style: TextStyle(fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  onPress: _addExercise,
                ),
                ReusableCard(
                  color: kActiveCardColor,
                  cardChild: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Add AI Meal',
                      style: TextStyle(fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  onPress: _retrieveAndAddRecipe,
                ),
              ],
            ),
          )

        ],
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  @override
  void dispose() {
    _caloriesController.dispose();
    _exerciseController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}