import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:daiet/components/reusable_card.dart';
import 'package:daiet/api/recipe_assistant.dart';
import 'package:daiet/constants.dart';
import 'dart:convert';

class ChatBotAnswerPage extends StatefulWidget {
  final String input;
  const ChatBotAnswerPage({Key? key, required this.input}) : super(key: key);

  @override
  State<ChatBotAnswerPage> createState() => _ChatBotAnswerPageState();
}

class _ChatBotAnswerPageState extends State<ChatBotAnswerPage> {
  late bool _loading = true;
  late String _output = "Loading answer...";

  @override
  void initState() {
    super.initState();
    _generateAnswer();
  }

  Future<void> _generateAnswer() async {
    String result = await generateAnswer(widget.input);
    setState(() {
      _output = result;
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
                      for(int i=0; i<3; i++) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Go back to home screen'),
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
