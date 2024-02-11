import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/custom_icon_card.dart';
import '../components/reusable_card.dart';
import '../constants.dart';
import 'results_page.dart';
import '../components/bottom_button.dart';
import '../components/round_icon_button.dart';
import 'package:daiet/calculator_brain.dart';
import 'input_page.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GET STARTED'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(
                    'assets/woman_running.jpeg'
                  ),
                ),
                Container(
                  child: Center(
                    child: AutoSizeText(
                      'Get started on the path to a healthy lifestyle! All with the things you already have in your fridge!',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  margin: EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.only(bottom: 0.0),
                  width: double.infinity,
                  height: kBottomContainerHeight,
                ),
                Container(
                  child: Center(
                    child: AutoSizeText(
                      'To start, please press GET STARTED below!',
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  margin: EdgeInsets.only(top: 0.0),
                  padding: EdgeInsets.only(bottom: 10.0),
                  width: double.infinity,
                  height: kBottomContainerHeight,
                ),
              ],
            ),
          ),
          BottomButton(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InputPage(),
                ),
              );
            },
            buttonTitle: 'GET STARTED',
          ),
        ],
      ),
    );
  }
}
