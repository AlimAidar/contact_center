import 'package:contact_center/src/common/dependencies/br_dio.dart';
import 'package:dio/dio.dart';

abstract class ConnectService {
  Future<void> connect(String number, String idSocket);
}

class ConnectServiceImplement extends ConnectService {
  ConnectServiceImplement({required BrDio brDio}) {
    dio = brDio.dio;
  } 
  late final Dio dio;

  @override
  Future<void> connect(String number, String idSocket) async {
    try {
      Response res = await dio.post(
        'websocket/manager/connect',
        queryParameters: {
          'phone_number': number,
          'id_socket': idSocket,
          'id_flutter': idSocket,
        },
      );
      print(res);
    } catch (e) {
      rethrow;
    }
  }
}
