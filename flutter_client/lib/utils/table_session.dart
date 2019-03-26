import 'dart:async';

import 'package:rest_in_peace/models/request_status.dart';
import 'package:rest_in_peace/utils/api.dart' as api;
import 'package:rest_in_peace/utils/message_transformer.dart';
import 'package:rest_in_peace/utils/stream_router.dart';
import 'package:web_socket_channel/io.dart';
import 'package:rest_in_peace/models/socket_message.dart';
import 'package:uuid/uuid.dart';

class TableSession {
  IOWebSocketChannel _tableChannel;
  Stream<SocketMessage> _messageStream;
  Map<String, Function(RequestStatus)> _waitingRequests;

  Uuid uuid;
  StreamRouter streamRouter;

  TableSession(String tableId) {
    uuid = new Uuid();
    _tableChannel = api.getTableChannel(tableId);
    SocketMessageTransformer transformer = new SocketMessageTransformer();
    _messageStream = _tableChannel.stream.transform(transformer);
    _waitingRequests = new Map();

    streamRouter = new StreamRouter(_messageStream);

    streamRouter.statusStream.listen((RequestStatus status) {
      if (_waitingRequests.containsKey(status.requestId)) {
        _waitingRequests.remove(status.requestId)(status);
        print("found request id: ${status.requestId}");
      }
    });
  }

  Stream<SocketMessage> get sessionStream {
    return _messageStream;
  }

  sendMessage(String message) {
    _tableChannel.sink.add(message);
  }

  Future<RequestStatus> sendMessageAndWaitStatus(SocketMessage message) {
    Completer<RequestStatus> statusReportCompleter = new Completer();
    String requestId = uuid.v4();
    _waitingRequests.putIfAbsent(
        requestId,
        () => (RequestStatus requestStatus) {
              statusReportCompleter.complete(requestStatus);
            });
    message.requestId = requestId;
    // put request id on message
    // _tableChannel.sink.add(message);
    _tableChannel.sink.add(successMessage(requestId)); //temp
    return statusReportCompleter.future;
  }

  terminate() {
    streamRouter.terminate();
  }
}

String successMessage(String messageId) {
  return """{
    "messageType": "WaitingStatusUpdate",
    "content": {
      "status": "SUCCESS",
      "requestId": "$messageId"
    }
}""";
}
