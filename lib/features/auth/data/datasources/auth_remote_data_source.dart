import 'dart:convert';
import 'package:dio/dio.dart';

import '../../../../config/dio/dio_config.dart';
import '../../../../core/error/exceptions.dart';

const String authBaseUrl = "https://dummyjson.com/auth";

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login(String username, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;
  AuthRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<Map<String, dynamic>> login(String username, String password) async {
    final Map<String, dynamic> loginData = {
      "username": username,
      "password": password,
    };
    var data = json.encode(loginData);
    final response = await dioClient.dio.request(
      '$authBaseUrl/login',
      options: Options(method: 'POST'),
      data: data,
    );
    if (response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    } else {
      throw ServerException(response.data["message"] ?? "Failed to log in");
    }
  }
}
