import 'package:contact_center/src/common/dependencies/br_dio.dart';
import 'package:dio/dio.dart';

abstract class ConnectService {
  Future<void> connect(String number, String idSocket, String idRoom);
}

class ConnectServiceImplement extends ConnectService {
  ConnectServiceImplement({required BrDio brDio}) {
    dio = brDio.dio;
  }
  late final Dio dio;

  @override
  Future<void> connect(String number, String idSocket, String idRoom) async {
    try {
       await dio.post(
        'websocket/manager/connect',
        queryParameters: {
          'phone_number': number,
          'id_socket': idSocket,
          'id_flutter': idSocket,
          'id_room': idRoom,
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
