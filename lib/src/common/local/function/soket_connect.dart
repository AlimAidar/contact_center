// import 'package:contact_center/src/common/models/tokens/token_model.dart';
// import 'package:contact_center/src/common/models/user/user_model.dart';
// import 'package:dio/dio.dart';
// import 'package:hive/hive.dart';

// final Box tokensBox = Hive.box('tokens');
// final Box userBox = Hive.box('user');
// Dio dio = Dio();

// socetConnect() async {
//   Response response = await dio.post(
//     'https://gateway.bpn.kz/api/login',
//     queryParameters: {
//       'login': 'touchpoint_user',
//       'password': 'YhvydD',
//     },
//   );
//   TokenModel tokensModel = TokenModel.fromJson(response.data);
//   UserModel userModel = UserModel.fromJson(response.data['user']);
//   tokensBox.put('access', tokensModel.accessToken);
//   userBox.put('id', userModel.id);
//   userBox.put('login', userModel.login);
//   userBox.put('created_at', userModel.createdAt);
//   userBox.put('updated_at', userModel.updatedAt);
//   userBox.put('id_role', userModel.idRole);
//   userBox.put('username', userModel.username);
//   userBox.put('position', userModel.position);
//   userBox.put('phone', userModel.phone);
//   userBox.put('email', userModel.email);


// }
