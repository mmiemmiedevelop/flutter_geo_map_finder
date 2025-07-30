import 'package:dio/dio.dart';
import '../models/address_model.dart';

class NaverRepository {
  final Dio _dio = Dio();

  Future<List<Address>?> search(String query) async {
    try {
      final response = await _dio.get(
        'https://openapi.naver.com/v1/search/local.json',
        queryParameters: {'query': query},
        options: Options(
          headers: {
            'X-Naver-Client-Id': '9nuzjkoJ928WN3FKlF2U',
            'X-Naver-Client-Secret': 'X_Nzgrsoib',
          },
        ),
      );

      if (response.statusCode == 200) {
        return List.from(
          response.data["items"],
        ).map((e) => Address.fromJson(e)).toList();
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
