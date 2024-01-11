import 'package:freezed_annotation/freezed_annotation.dart';

part 'manager_user_model.freezed.dart';
part 'manager_user_model.g.dart';

@freezed
class ManagerUserModel with _$ManagerUserModel {

  factory ManagerUserModel({
 String? username,
 String? photo
  }) = _ManagerUserModel;

  factory ManagerUserModel.fromJson(Map<String, dynamic> json) => _$ManagerUserModelFromJson(json);
}

List model = [
  {
    "id": 2,
    "id_component": 3,
    "id_user": 30,
    "id_group": 11,
    "is_admin": false,
    "created_by": 1,
    "created_at": null,
    "updated_at": null,
    "component": {
      "id": 3,
      "id_comp": null,
      "component_name": "Orders",
      "component_desc": null,
      "change_logs": null,
      "is_active": true,
      "is_basic": true,
      "created_by": 1,
      "created_at": "2023-05-01T23:16:22.000000Z",
      "updated_at": "2023-05-01T23:16:22.000000Z",
    },
    "user": {
      "id": 30,
      "login": "farhat.m",
      "created_at": "2023-06-06T05:41:04.000000Z",
      "updated_at": "2023-06-06T05:41:04.000000Z",
      "id_role": 5,
      "username":
          "\u0424\u0430\u0440\u0445\u0430\u0442 \u041c\u044b\u0440\u0437\u0430\u0442\u0430\u0435\u0432",
      "position": null,
      "phone": null,
      "email": null,
      "verified": false,
      "id_city": null,
    },
    "group": {
      "id": 11,
      "id_component": 3,
      "group_type": 1,
      "group_name": "\u041a-\u041f\u0440\u043e\u0432\u0435\u0440\u043a\u0430",
      "channel": 0,
      "enabled": true,
      "created_by": 1,
      "created_at": "2023-05-01T23:16:23.000000Z",
      "updated_at": "2023-05-01T23:16:23.000000Z"
    }
  },
  {
    "id": 3,
    "id_component": 3,
    "id_user": 29,
    "id_group": 11,
    "is_admin": false,
    "created_by": 1,
    "created_at": null,
    "updated_at": null,
    "component": {
      "id": 3,
      "id_comp": null,
      "component_name": "Orders",
      "component_desc": null,
      "change_logs": null,
      "is_active": true,
      "is_basic": true,
      "created_by": 1,
      "created_at": "2023-05-01T23:16:22.000000Z",
      "updated_at": "2023-05-01T23:16:22.000000Z",
    },
    "user": {
      "id": 29,
      "login": "dilhan.a",
      "created_at": "2023-06-06T05:39:58.000000Z",
      "updated_at": "2023-06-06T05:39:58.000000Z",
      "id_role": 10,
      "username":
          "\u0414\u0438\u043b\u044c\u0445\u0430\u043d \u0410\u0431\u0434\u0443\u043b\u0430\u0445\u0430\u0442\u043e\u0432",
      "position": null,
      "phone": null,
      "email": null,
      "verified": true,
      "id_city": null
    },
    "group": {
      "id": 11,
      "id_component": 3,
      "group_type": 1,
      "group_name": "\u041a-\u041f\u0440\u043e\u0432\u0435\u0440\u043a\u0430",
      "channel": 0,
      "enabled": true,
      "created_by": 1,
      "created_at": "2023-05-01T23:16:23.000000Z",
      "updated_at": "2023-05-01T23:16:23.000000Z"
    },
  },
];
