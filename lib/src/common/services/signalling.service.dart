import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart';

class SignallingService {
  // instance of Socket
  Socket? socket;

  SignallingService._();
  static final instance = SignallingService._();

  init({
    required String websocketUrl,
    required String selfCallerID,
    required String token,
  }) {
    socket = io(websocketUrl, {
      "transports": ['websocket'],
      "auth": {"token":token},
    });

    socket!.onConnect((data) {
      log("Socket connected !!");
    });
    socket!.onConnectError((data) {
      log("Connect Error $data");
    });

    socket!.connect();
  }

  disconnect() {
    socket!.close();
    log('disconnect');
  }
}
