import 'package:contact_center/src/common/dependencies/br_dio.dart';
import 'package:dio/dio.dart';

abstract class UpdateIdService {
  Future<void> updateId(String idSoket,String idRoom);
}

class UpdateIdServiceImplement extends UpdateIdService {
 UpdateIdServiceImplement({required BrDio brDio}) {
    dio = brDio.dio;
  }
  late final Dio dio;

  @override
  Future<void> updateId(String idSoket,String idRoom) async {
    try {
       await dio.post(
        '/api/call/session/status/update',
        queryParameters: {
          'id_room': idRoom,
          'id_socket': '123',
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
