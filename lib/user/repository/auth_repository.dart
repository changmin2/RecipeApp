import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/common/dio/dio.dart';

import '../../common/const/data.dart';
import '../model/login_response.dart';

final authRepositoryProivder = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return AuthRepository(baseUrl: 'http://$ip/members', dio: dio);
});

class AuthRepository{
  final String baseUrl;
  final Dio dio;

  AuthRepository({
    required this.baseUrl,
    required this.dio
  });

  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {

    final resp = await dio.post(
        '$baseUrl/login',
        data: {
          'memberId':username,
          'password':password
        }
    );

    return LoginResponse.fromJson(resp.data);
  }

  Future<void> withDrawl()async {
    await dio.get(
      '$baseUrl/withDrawal',
      options: Options(
        headers: {
          'accessToken':'true'
        }
      )
    );
  }
}