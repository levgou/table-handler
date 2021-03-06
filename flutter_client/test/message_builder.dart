import 'package:rest_in_peace/models/socket_message.dart';

class MessageBuilder {
  Map generateStatusUpdate() {
    return SocketMessage(MessageType.statusUpdate, baseTableStatus).toJson();
  }
}

const baseTableStatus = {
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
        {"name": "Egg", "price": 7}
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
  "cart": ["1", "2", "7"]
};

const success = """{
    "messageType": "CartRequestStatusUpdate",
    "content": {
      "status": "SUCCESS",
      "requestId": "1234"
    }
}""";

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
