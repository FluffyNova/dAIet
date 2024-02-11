import 'package:daiet/constants.dart';
import 'package:daiet/components/reusable_card.dart';
import 'package:flutter/material.dart';
import '../components/bottom_button.dart';
import 'calories_page.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'daily_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:daiet/components/custom_icon_card.dart';
import 'chatbot.dart';

class AIPage extends StatelessWidget {
  const AIPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('AI Assistant')
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CaloriesPage(
                              caloriesResult: 2000, // placeholder
                            ),
                          ),
                        );
                      },
                      color: kActiveCardColor,
                      cardChild: CustomIconCard(
                          icon: Icons.fastfood, text: 'RECIPE HELPER')),
                ),
                Expanded(
                  child: ReusableCard(
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatBotPage(), // placehodler
                          ),
                        );
                      },
                      color: kActiveCardColor,
                      cardChild: CustomIconCard(
                          icon: FontAwesomeIcons.robot, text: 'NUTRITION CHATBOT')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
