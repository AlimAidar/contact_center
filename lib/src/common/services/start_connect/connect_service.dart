import 'package:contact_center/src/common/dependencies/br_dio.dart';
import 'package:dio/dio.dart';

abstract class ConnectService {
  Future<void> connect(String number,  String idRoom);
}

class ConnectServiceImplement extends ConnectService {
  ConnectServiceImplement({required BrDio brDio}) {
    dio = brDio.dio;
  }
  late final Dio dio;

  @override
  Future<void> connect(String number,  String idRoom) async {
    try {
       await dio.post(
        'websocket/manager/connect',
        queryParameters: {
          'phone_number': number,
          'id_socket': '123',
          'id_flutter': '123',
          'id_room': idRoom,
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
