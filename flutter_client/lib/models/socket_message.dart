class SocketMessage {
  MessageType type;
  dynamic content;
  String requestId;
  SocketMessage(this.type, [this.content, this.requestId]);

  SocketMessage.fromJson(Map json) {
    type = MESSAGE_TYPES.containsKey(json['messageType'])
        ? MESSAGE_TYPES[json['messageType']]
        : MessageType.unknown;
    content = json['content'];
  }

  Map toJson() {
    return {
      'type':
          MESSAGE_TYPES.keys.singleWhere((key) => MESSAGE_TYPES[key] == type),
      'content': content,
      'requestId': requestId
    };
  }
}

const Map<String, MessageType> MESSAGE_TYPES = const {
  'TableStatusUpdate': MessageType.statusUpdate,
  'WaitingStatusUpdate': MessageType.waitingStatusUpdate,
  'RequestAddToCart': MessageType.requestAddToCart,
  'RequestRemoveFromCart': MessageType.requestRemoveFromCart,
  'RequestStatusUpdate': MessageType.requestStatusUpdate
};

enum MessageType {
  unknown,
  statusUpdate,
  waitingStatusUpdate,
  requestStatusUpdate,
  requestRemoveFromCart,
  requestAddToCart
}
