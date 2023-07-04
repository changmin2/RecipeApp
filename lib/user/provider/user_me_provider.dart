import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recipe_app/common/secure_storage/secure_storage.dart';
import 'package:recipe_app/user/model/duplicate_request.dart';
import 'package:recipe_app/user/repository/user_me_repository.dart';

import '../../common/const/data.dart';
import '../model/user_model.dart';
import '../repository/auth_repository.dart';

final userMeProvider = StateNotifierProvider<UserMeStateNotifier,UserModelBase?>((ref) {
  final authRepository = ref.watch(authRepositoryProivder);
  final userMeRepository = ref.watch(userMeRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);

  return UserMeStateNotifier(
      authRepository: authRepository,
      userMeRepository: userMeRepository,
      storage: storage
  );
});

class UserMeStateNotifier extends StateNotifier<UserModelBase?>{
  final AuthRepository authRepository;
  final UserMeRepository userMeRepository;
  final FlutterSecureStorage storage;


  UserMeStateNotifier({
    required this.authRepository,
    required this.userMeRepository,
    required this.storage
  }) : super(UserModelLoading()){
    //내정보 가져오기
    getMe();
  }


  Future<void> getMe() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    //spalsh화면을 2초 보여주기 위한 스탑워치
    Stopwatch stopwatch = new Stopwatch();
    stopwatch.start();

    if(refreshToken == null || accessToken == null){
      await Future.delayed(Duration(milliseconds: (1800)));
      state = null;
      return;
    }

    final resp = await userMeRepository.getMe();
    Duration get = stopwatch.elapsed;
    stopwatch.stop();
    if(get.inMilliseconds<2000){
      await Future.delayed(Duration(milliseconds: (2000-get.inMilliseconds)));
    }
    state = resp;


  }
  Future<UserModelBase> login({
    required String username,
    required String password
  }) async{
    try{
      state = UserModelLoading();

      final resp = await authRepository.login(username: username, password: password);

      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.accessToken);
      await storage.write(key: REFRESH_TOKEN_KEY, value: resp.refreshToken);
      print('login진입');
      final userResponse = await userMeRepository.getMe();
      print('login아웃');
      state = userResponse;

      return userResponse;
    }catch(e){

      state = UserModelError(message: '로그인에 실패했습니다.');

      return Future.value(state);
    }
  }

  Future<void> logout() async {
    state = null;
    //동시에 실행
    Future.wait([
      storage.delete(key: REFRESH_TOKEN_KEY),
      storage.delete(key: ACCESS_TOKEN_KEY)
    ]);

    //await storage.delete(key: REFRESH_TOKEN_KEY);
    //await storage.delete(key: ACCESS_TOKEN_KEY);
  }

}