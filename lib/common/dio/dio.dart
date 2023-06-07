

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/common/secure_storage/secure_storage.dart';
import 'package:recipe_app/user/provider/auth_provider.dart';
import 'package:recipe_app/user/view/login_screen.dart';

import '../const/data.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  final storage = ref.watch(secureStorageProvider);

  dio.interceptors.add(
    CustomInterceptor(storage: storage, ref: ref)
  );

  return dio;
});

class CustomInterceptor extends Interceptor{
  final FlutterSecureStorage storage;
  final Ref ref;

  CustomInterceptor({
    required this.storage,
    required this.ref
  });

  //1) 요청을 보낼때, 요청이 보내지기전
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    print('[REQ] [${options.method}] ${options.uri}');

    if(options.headers['accessToken']=='true'){
      options.headers.remove('accessToken');

      final token = await storage.read(key:ACCESS_TOKEN_KEY);

      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    if(options.headers['refreshToken']=='true'){
      options.headers.remove('refreshToken');

      final token = await storage.read(key: REFRESH_TOKEN_KEY);
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    // TODO: implement onRequest
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    ref.read(authProvider).logout();
    return handler.reject(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');

    // TODO: implement onResponse
    return super.onResponse(response, handler);
  }
}