
import 'package:contact_center/src/common/services/signalling.service.dart';
import 'package:hive/hive.dart';

final Box tokensBox = Hive.box('tokens');

socetConnect() {
  SignallingService.instance.init(
    token: tokensBox.get('access'),
    websocketUrl: "ws://192.168.0.49:5005",
    selfCallerID: 'qwe123',
  );
}

