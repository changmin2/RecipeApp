import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/common/dio/dio.dart';
import 'package:retrofit/http.dart';
import '../../common/const/data.dart';
import '../model/user_model.dart';

part 'user_me_repository.g.dart';

final userMeRepositoryProvider = Provider<UserMeRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return UserMeRepository(dio,baseUrl: 'http://$ip/members');
});

@RestApi()
abstract class UserMeRepository{
  factory UserMeRepository(Dio dio,{String baseUrl}) = _UserMeRepository;

  @GET('/me')
  @Headers({
    'accessToken':'true'
  })
  Future<UserModel> getMe();
}