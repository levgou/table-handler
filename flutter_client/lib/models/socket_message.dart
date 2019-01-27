class SocketMessage {
  MessageType type;
  dynamic content;

  SocketMessage.fromJson(Map json) {
    type = MESSAGE_TYPES.containsKey(json['messageType'])
        ? MESSAGE_TYPES[json['messageType']]
        : MessageType.unknown;
    content = json['content'];
  }
}

const Map<String, MessageType> MESSAGE_TYPES = const {
  'TableStatusUpdate': MessageType.statusUpdate,
  'CartRequestStatusUpdate': MessageType.cartRequestStatusUpdate
};

enum MessageType {
  unknown,
  statusUpdate,
  cartRequestStatusUpdate,
}
