import 'package:contact_center/src/common/dependencies/br_dio.dart';
import 'package:contact_center/src/common/models/tokens/token_model.dart';
import 'package:contact_center/src/common/models/user/user_model.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class AuthService {
  Future<UserModel> authorize(String email, String password);
}

class AuthServiceImplement extends AuthService {
  AuthServiceImplement({required BrDio brDio}) {
    dio = brDio.dio;
  }
  late final Dio dio;

  final Box tokensBox = Hive.box('tokens');
  final Box userBox = Hive.box('user');

  @override
  Future<UserModel> authorize(String email, String password) async {
    try {
      Response response = await dio.post(
        'api/login',
        queryParameters: {
          'login': email,
          'password': password,
        },
      );
      TokenModel tokensModel = TokenModel.fromJson(response.data);
      UserModel userModel = UserModel.fromJson(response.data['user']);
      tokensBox.put('access', tokensModel.accessToken);
      userBox.put('id', userModel.id);
      userBox.put('login', userModel.login);
      userBox.put('created_at', userModel.createdAt);
      userBox.put('updated_at', userModel.updatedAt);
      userBox.put('id_role', userModel.idRole);
      userBox.put('username', userModel.username);
      userBox.put('position', userModel.position);
      userBox.put('phone', userModel.phone);
      userBox.put('email', userModel.email);

      return userModel;
    } catch (e) {
      rethrow;
    }
  }
}
