class RequestStatus {
  StatusType status;
  String requestId;

  RequestStatus.fromJson(Map json) {
    status = STATUS_TYPES.containsKey(json['status'])
        ? STATUS_TYPES[json['status']]
        : StatusType.unknown;
    requestId = json['requestId'];
  }
}

const Map<String, StatusType> STATUS_TYPES = const {
  'SUCCESS': StatusType.success
};

enum StatusType { success, unknown }
