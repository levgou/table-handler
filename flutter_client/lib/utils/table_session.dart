import 'package:rest_in_peace/utils/api.dart' as api;
import 'package:rest_in_peace/utils/message_transformer.dart';
import 'package:web_socket_channel/io.dart';
import 'package:rest_in_peace/models/socket_message.dart';

class TableSession {
  IOWebSocketChannel _tableChannel;
  Stream<SocketMessage> _messageStream;

  TableSession(String tableId) {
    _tableChannel = api.getTableChannel(tableId);
    SocketMessageTransformer transformer = new SocketMessageTransformer();
    _messageStream = _tableChannel.stream.transform(transformer);
  }

  Stream<SocketMessage> get sessionStream {
    return _messageStream;
  }

  sendMessage(String message) {
    _tableChannel.sink.add(message);
  }
}
