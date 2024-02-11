import 'package:daiet/api/dio_client.dart';
import 'package:daiet/models/palm_model.dart';

class PaLMDataSource {
  PaLMDataSource({required this.dioClient});
  final DioClient dioClient;

  Future<PaLMModel> generateText(String text, String apiKey) async {
    const url = 'https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText';

    final queryParameters = {'key': apiKey};
    final body = {'prompt': {'text': text}, "temperature": 1.0, "candidateCount": 2};

    final response = await dioClient.post(url, queryParameters: queryParameters, data: body);

    return PaLMModel.fromJson(response.data);
  }
}