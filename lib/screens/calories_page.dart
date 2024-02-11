import 'package:flutter/material.dart';
import 'package:daiet/components/bottom_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'recipe_helper.dart';

class CaloriesPage extends StatelessWidget {
  CaloriesPage({required this.caloriesResult});

  final int caloriesResult;
  late var myController = TextEditingController();
  late String input;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WHAT\'S IN YOUR FRIDGE?'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      child: Image(
                        image: AssetImage(
                            'assets/confused_man.jpeg'
                        ),
                      ),
                      padding: EdgeInsets.all(12.0)
                  ),
                  Padding(
                      child: AutoSizeText(
                        'Give us a general idea of what\'s in your fridge! Be as sparse or as detailed as possible!',
                        style: TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.all(12.0)),
                  Container(
                    child: TextField(
                      controller: myController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '4 eggs, 2 sticks of butter, flour...',
                      ),
                    ),
                  ),
                ],
              )
          ),
          BottomButton(
            onTap: () {
              input = myController.text;
              if(input.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeHelperPage(input: input),
                  ),
                );
              }
            },
            buttonTitle: 'SUBMIT',
          ),
        ],
      ),
    );
  }
}
