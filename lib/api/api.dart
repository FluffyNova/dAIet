// import 'package:dart_openai/dart_openai.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
//
// // the system message that will be sent to the request.
// final systemMessage = OpenAIChatCompletionChoiceMessageModel(
//   content: [
//     OpenAIChatCompletionChoiceMessageContentItemModel.text(
//       "return any message you are given as JSON.",
//     ),
//   ],
//   role: OpenAIChatMessageRole.assistant,
// );
//
// // the user message that will be sent to the request.
// final userMessage = OpenAIChatCompletionChoiceMessageModel(
//   content: [
//     OpenAIChatCompletionChoiceMessageContentItemModel.text(
//       "Hello, I am a chatbot created by OpenAI. How are you today?",
//     ),
//
//     //! image url contents are allowed only for models with image support such gpt-4.
//     OpenAIChatCompletionChoiceMessageContentItemModel.imageUrl(
//       "https://placehold.co/600x400",
//     ),
//   ],
//   role: OpenAIChatMessageRole.user,
// );
//
// // all messages to be sent.
// final requestMessages = [
//   systemMessage,
//   userMessage,
// ];
//
// print(chatCompletion.choices.first.message); // ...
// print(chatCompletion.systemFingerprint); // ...
// print(chatCompletion.usage.promptTokens); // ...
// print(chatCompletion.id); // ...
// getRecipes () async {
//   OpenAI.baseUrl = "https://api.openai.com/v1";
//
//   http.Response res = await http.get(Uri.http(url, '/api/v1/recipe'));
// }