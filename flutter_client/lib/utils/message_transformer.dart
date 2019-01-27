import 'dart:async';
import 'dart:convert';
import 'package:rest_in_peace/models/socket_message.dart';

class SocketMessageTransformer
    implements StreamTransformer<dynamic, SocketMessage> {
  @override
  Stream<SocketMessage> bind(Stream<dynamic> stream) {
    return new Stream<SocketMessage>.eventTransformed(
      stream,
      (EventSink sink) => new SocketMessageSink(sink),
    );
  }

  @override
  StreamTransformer<RS, RT> cast<RS, RT>() {
    // TODO: implement cast
    return null;
  }
}

class SocketMessageSink implements EventSink<dynamic> {
  final EventSink<SocketMessage> _output;

  SocketMessageSink(this._output);

  @override
  void add(dynamic event) {
    _output.add(new SocketMessage.fromJson(json.decode(event)));
  }

  @override
  void addError(Object error, [StackTrace stackTrace]) {
    _output.addError(error, stackTrace);
  }

  @override
  void close() {
    _output.close();
  }
}
