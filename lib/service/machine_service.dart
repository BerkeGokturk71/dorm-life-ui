import 'package:dio/dio.dart';
import 'package:tester/model/machine_loan_model.dart';

class LoanService {
  final Dio _dio;

  LoanService(String bearerToken)
      : _dio = Dio(
          BaseOptions(
            baseUrl: "https://dorm-api-1d77.onrender.com/",
            headers: {
              'Authorization': 'Bearer $bearerToken', // Bearer Token ekleniyor
              'Content-Type': 'application/json', // İçerik türü belirleniyor
            },
          ),
        );

  Future<LoanModel?> loanPost(LoanModel loanData) async {
    try {
      // LoanModel'i JSON'a çeviriyoruz
      final response = await _dio.post(
        "/loan/loan-machine",
        data: loanData.toJson(), // POST verisi olarak LoanModel'i gönderiyoruz
      );

      final data = response.data;

      if (data is Map<String, dynamic>) {
        return LoanModel.fromJson(data); // Gelen veriyi LoanModel'e çeviriyoruz
      }

      return null;
    } catch (e) {
      print("Error posting data: $e");
      return null;
    }
  }
}
