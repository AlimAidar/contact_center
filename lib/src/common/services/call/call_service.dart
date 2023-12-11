import 'package:contact_center/src/common/dependencies/br_dio.dart';
import 'package:dio/dio.dart';

abstract class CallService {
  Future<void> postNumber(String number,String idSocket);
}

class CallServiceImplement extends CallService {
  CallServiceImplement({required BrDio brDio}) {
    dio = brDio.dio;
  }
  late final Dio dio;

  @override
  Future<void> postNumber(String number,String idSocket) async {
    try {
      Response res = await dio.post(
        'api/call/client/begin',
        queryParameters: {
          'phone_number': number,
          'id_flutter':idSocket,
          'id_socket':idSocket,
        },
      );
      print(res);
    } catch (e) {
      rethrow;
    }
  }
}
// ""4P7NmWczQWaJ0nAbAAjB""