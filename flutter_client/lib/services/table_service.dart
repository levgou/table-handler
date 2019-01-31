import 'package:rest_in_peace/models/item.dart';
import 'package:rest_in_peace/models/request_status.dart';
import 'package:rest_in_peace/models/socket_message.dart';
import 'package:rest_in_peace/utils/table_session.dart';
import 'package:rest_in_peace/utils/stream_router.dart';

class TableService {
  StreamRouter streamRouter;
  TableSession _tableSession;

  TableService() {
    _tableSession = new TableSession("some-uid");
    streamRouter = _tableSession.streamRouter;
  }

  requestTableUpdate() {
    // String response = SocketMessageBuilder.tableStatusUpdate();
    // new SocketMessage(MessageType.requestStatusUpdate)
    _tableSession.sendMessage(messageJson);
  }

  Future<RequestStatus> requestAddToCart(Item item) async {
    return await _tableSession.sendMessageAndWaitStatus(
        new SocketMessage(MessageType.requestAddToCart, {"itemId": item.id}));
  }

  Future<RequestStatus> requestRemoveFromCart(Item item) async {
    return await _tableSession.sendMessageAndWaitStatus(new SocketMessage(
        MessageType.requestRemoveFromCart, {"itemId": item.id}));
  }
}

const messageJson = """{
    "messageType": "TableStatusUpdate",
    "content": {
      "id": "some-uuid",
      "title": "some table",
        "items": [
          {
            "id": "134",
            "name": "Coka-cola",
            "category": "DRINK",
            "type": "SOFT_DRINK",
            "price": 10.00,
            "status": "PENDING"
          },
          {
            "id": "521",
            "name": "Hamburger",
            "category": "FOOD",
            "type": "HAMBURGER",
            "price": 40.00,
            "status": "PENDING",
            "subitems": [
              {
                "name": "Egg",
                "price": 7
              }
            ]
          },
          {
            "id": "221",
            "name": "Hoegarden",
            "category": "DRINK",
            "type": "BEER",
            "price": 33.00,
            "status": "PENDING"
          },
          {
            "id": "21",
            "name": "Snitzel",
            "category": "FOOD",
            "price": 45.00,
            "status": "PENDING"
          },
          {
            "id": "7",
            "name": "Pinacolada",
            "category": "DRINK",
            "type": "COKTAIL",
            "price": 39.00,
            "status": "IN_CART"
          },
          {
            "id": "987",
            "name": "Hamburger",
            "category": "FOOD",
            "type": "HAMBURGER",
            "price": 45.00,
            "status": "PENDING"
          },
          {
            "id": "6745",
            "name": "Sufle",
            "category": "FOOD",
            "type": "DESERT",
            "price": 30.00,
            "status": "PENDING"
          },
          {
            "id": "2",
            "name": "Susage",
            "category": "FOOD",
            "type": "MEAT",
            "price": 30.00,
            "status": "IN_CART"
          },
          {
            "id": "18",
            "name": "Fanta",
            "category": "DRINK",
            "type": "SOFT_DRINK",
            "price": 10.00,
            "status": "PENDING"
          },
          {
            "id": "14",
            "name": "Hamburger",
            "type": "HAMBURGER",
            "category": "FOOD",
            "price": 45.00,
            "status": "IN_CART"
          },
          {
            "id": "1",
            "name": "Coka-cola",
            "category": "DRINK",
            "type": "SOFT_DRINK",
            "price": 10.00,
            "status": "IN_CART"
          }
        ],
      "cart": [
        "1",
        "2",
        "7"
      ]
    }
  } 
""";
