package models.message.world.impl.in

import play.api.libs.json.{JsValue, Json, OFormat}

case class JsonInputMessage(messageType: String, content: JsValue)

object JsonInputMessage {
    implicit val fmt: OFormat[JsonInputMessage] = Json.format[JsonInputMessage]
}
