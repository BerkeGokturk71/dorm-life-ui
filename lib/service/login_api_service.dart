import 'package:dio/dio.dart';
import 'package:tester/model/login_post_model.dart';

class LoginService {
  final Dio _dio;
  LoginService()
      : _dio = Dio(BaseOptions(baseUrl: "https://dorm-api-1d77.onrender.com"));

  Future<LoginModel?> loginItem(LoginModel loginData) async {
    try {
      // LoginModel'i JSON'a çeviriyoruz
      final response = await _dio.post(
        "/login",
        data:
            loginData.toJson(), // POST verisi olarak LoginModel'i gönderiyoruz
      );

      final data = await response.data;

      if (data is Map<String, dynamic>) {
        return LoginModel.fromJson(
            data); // Gelen veriyi LoginModel'e çeviriyoruz
      }

      return null;
    } catch (e) {
      print("Error posting data: $e");
      return null;
    }
  }
}
