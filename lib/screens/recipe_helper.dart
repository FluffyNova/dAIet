import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:daiet/components/reusable_card.dart';
import 'package:daiet/api/recipe_assistant.dart';
import 'package:daiet/constants.dart';
import 'dart:convert';

class RecipeHelperPage extends StatefulWidget {
  final String input;
  const RecipeHelperPage({Key? key, required this.input}) : super(key: key);

  @override
  State<RecipeHelperPage> createState() => _RecipeHelperPageState();
}

class _RecipeHelperPageState extends State<RecipeHelperPage> {
  late bool _loading = true;
  late String _output = "Loading recipe...";

  @override
  void initState() {
    super.initState();
    _loadRecipe();
    _generateRecipe();
  }

  Future<void> _generateRecipe() async {
    String result = await generateRecipe(widget.input);
    _saveRecipe(result);
    setState(() {
      _output = result;
      _loading = false;
    });
  }

  Future<void> _saveRecipe(String recipe) async {
    final String recipeJson = json.encode(recipe);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedRecipe', recipeJson);
  }

  Future<void> _loadRecipe() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _output = prefs.getString('savedRecipe') ?? "No saved recipe. Generate one!";
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Recipe Helper'),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ReusableCard(
              color: kActiveCardColor,
              cardChild: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  _output,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              onPress: () {
                // Implement what should happen when the card is pressed
              },
            ),Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      Container(
                        padding: EdgeInsets.all(8.0),
                        color: kActiveCardColor,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kActiveCardColor,
                            ),
                          onPressed: () {
                            _saveRecipe;
                            for(int i=0; i<3; i++) {
                              Navigator.pop(context);
                            }

                          },
                          child: const Text('Save recipe'),
                        ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      color: kActiveCardColor,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kActiveCardColor,
                        ),
                        onPressed: _generateRecipe,
                        child: const Text('Generate new recipe'),
                      ),
                    ),
                  ],
            ),
          ],
        ),
      ),
    );
  }
}
