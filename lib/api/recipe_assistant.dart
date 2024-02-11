import 'package:flutter/material.dart';
import 'package:daiet/constants.dart';
import 'package:daiet/api/palm_data_source.dart';
import 'package:daiet/models/palm_model.dart';
import 'dio_client.dart';

// Assuming your PaLMDataSource and DioClient are set up as previously described
Future<String> generateRecipe(String ingredients) async {
  final String apiKey = kPalmKey; // Your Google Bard API key
  final PaLMDataSource dataSource = PaLMDataSource(dioClient: DioClient()); // Initialize your Dio client here

  try {
    final prompt = '''
    Given the following ingredients: $ingredients, create a nutritious recipe including only these items (maybe using other ingredients that are easy to find i.e. salt, pepper, water or low costing i.e. eggs, milk). Please format the recipe as follows:
    Recipe Name: [Name of the Recipe]
    Ingredients:
    - Ingredient 1
    - Ingredient 2
    - (Continue with the rest of the provided ingredients, and add any additional ingredients needed for a balanced recipe)
    Instructions:
    1. [Step by step cooking instructions]

    Nutritional Information:
    - Calories: [Amount]
    - Protein: [Amount] grams
    - Fat: [Amount] grams
    - Carbohydrates: [Amount] grams

    Note: Prioritize whole foods and healthy preparation methods.
    ''';

    final PaLMModel response = await dataSource.generateText(prompt, apiKey);
    if (response.candidates.isNotEmpty) {
      // Assuming response structure matches your PaLMModel and you want the first candidate's output
      return response.candidates.first.output;
    } else {
      return "No recipe could be generated based on the given ingredients.";
    }
  } catch (e) {
    // General catch for any other exceptions/errors
    return 'Failed to generate recipe: $e';
  }
}

Future<String> generateAnswer(String question) async {
  final String apiKey = kPalmKey; // Your Google Bard API key
  final PaLMDataSource dataSource = PaLMDataSource(dioClient: DioClient()); // Initialize your Dio client here

  try {
    final prompt = '''
    Given the following question: $question, please answer it shortly, respectfully, and with good information!

    Note: Prioritize nutrition and good exercise methods.
    ''';

    final PaLMModel response = await dataSource.generateText(prompt, apiKey);
    if (response.candidates.isNotEmpty) {
      // Assuming response structure matches your PaLMModel and you want the first candidate's output
      return response.candidates.first.output;
    } else {
      return "No answer could be generated.";
    }
  } catch (e) {
    // General catch for any other exceptions/errors
    return 'Failed to generate answer: $e';
  }
}
