import 'package:contact_center/src/common/models/tokens/token_model.dart';
import 'package:contact_center/src/common/models/user/user_model.dart';
import 'package:contact_center/src/common/services/signalling.service.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

final Box tokensBox = Hive.box('tokens');
final Box userBox = Hive.box('user');
Dio dio = Dio();

socetConnect() async {
  Response response = await dio.post(
    'http://192.168.0.49:8082/api/login',
    queryParameters: {
      'login': 'touchpoint',
      'password': '670894439',
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

  await SignallingService.instance.init(
    token: tokensModel.accessToken,
    websocketUrl: "ws://192.168.0.49:5005",
    selfCallerID: 'qwe123',
  );
}
