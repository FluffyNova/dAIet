import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:daiet/components/reusable_card.dart';
import 'package:daiet/api/recipe_assistant.dart';
import 'package:daiet/constants.dart';
import 'package:daiet/components/bottom_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:daiet/components/custom_icon_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'chatbot_answer.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({Key? key}) : super(key: key);

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  late bool _loading = true;
  late String _output = "Loading recipe...";

  late var myController = TextEditingController();
  late String input;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nutrition Chatbot'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconCard(icon: FontAwesomeIcons.robot, text: 'AI CHATBOT'),
                  Padding(
                      child: AutoSizeText(
                        'Feel free to ask any question about nutrition, exercise, or whatever\'s on your mind!',
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
                        hintText: 'Type question here!',
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
                      builder: (context) => ChatBotAnswerPage(input: input)
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
