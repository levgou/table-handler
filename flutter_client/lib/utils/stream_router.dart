import 'dart:async';

import 'package:rest_in_peace/models/request_status.dart';
import 'package:rest_in_peace/models/socket_message.dart';
import 'package:rest_in_peace/models/table_status.dart';

class StreamRouter {
  Stream streams;

  Stream<TableStatus> tableStatusUpdateStream;
  StreamController<TableStatus> _tableStatusStreamController;
  Stream<RequestStatus> cartStatusStream;
  StreamController<RequestStatus> _cartStatusStreamController;

  StreamRouter(Stream<SocketMessage> inputStream) {
    _tableStatusStreamController = new StreamController();
    _cartStatusStreamController = new StreamController();
    tableStatusUpdateStream = _tableStatusStreamController.stream;
    cartStatusStream = _cartStatusStreamController.stream;

    inputStream.listen((SocketMessage message) {
      // try asBroadCastStream and using Where
      switch (message.type) {
        case MessageType.statusUpdate:
          _tableStatusStreamController.sink
              .add(new TableStatus.fromJson(message.content));
          break;
        case MessageType.cartRequestStatusUpdate:
          _cartStatusStreamController.sink
              .add(new RequestStatus.fromJson(message.content));
          break;
        default:
          break;
      }
    });
  }
}
