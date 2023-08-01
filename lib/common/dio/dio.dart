

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
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    //401에러가 났을때
    //토큰을 재발급 받는 시도를하고 토큰이 재발급되면
    //다시 새로운 토큰으로 요청을한다.

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    //refreshToken 아예 없으면
    // 당연히 에러를 던진다
    if(refreshToken==null){
      //에러를 던질때는 handler.reject를 사용한다.
      ref.read(authProvider).logout();
      return handler.reject(err);
    }
    //401이면 true
    //final isStatus401 = err.response!.statusMessage
    //token을 발급 받으려다가 실패 한 경우
    final isPathRefresh = err.requestOptions.path == '/members/token';

    //refresh토큰을 발급 하려다 실패한 것도 아니고 401 에러가 떳을 때
    if(!isPathRefresh) {
      final dio = Dio();
      try {
        final resp = await dio.post(
            'http://$ip/members/token',
            options: Options(
                headers: {
                  'authorization': 'Bearer $refreshToken'
                }
            )
        );

        final accessToken = resp.data['accessToken'];

        final options = err.requestOptions;

        options.headers.addAll({
          'authorization': 'Bearer $accessToken'
        });

        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
        //에러를 발생 한 요청과 관련된 옵션을 받은 후 토큰만 변경한 후 요청 재전송
        final response = await dio.fetch(options);

        //응답이 성공 했을 때
        return handler.resolve(response);
      } on DioError catch (e) { //토큰이 만료됐을때
        //circular dependecny error -> userMeProvidr Logout로직을 실행했을 때 발생
        //무한루프 발생
        //ref.read(userMeProvider.notifer).logout()
        // userMeProvider는 디오가 필요하고
        //디오는 uerMeProvider가 필요하고 무한루프
        ref.read(authProvider).logout();

        return handler.reject(err);
      }
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');

    // TODO: implement onResponse
    return super.onResponse(response, handler);
  }
}