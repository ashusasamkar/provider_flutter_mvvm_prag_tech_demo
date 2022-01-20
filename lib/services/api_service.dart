import 'package:dio/dio.dart';

class Api {

  static Future<dynamic>  userDataApi() async {
    return Dio().get("https://jsonplaceholder.typicode.com/users").then(
          (response) {
        int? code = response.statusCode;
        print('Response getApi  : $code...');
        if (code! < 200 || code > 400) {
          throw Exception('Error while getting data');
        }
        return response.data;
      },
    );
  }
}
