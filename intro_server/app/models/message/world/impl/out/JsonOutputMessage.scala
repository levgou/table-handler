package models.message.world.impl.out

import models.message.world.interfaces.out.OutputMessage
import play.api.libs.json.{JsValue, Json, OFormat}


case class JsonOutputMessage(outMessageType: String, msg: JsValue)

object JsonOutputMessage {
    implicit val fmt: OFormat[JsonOutputMessage] = Json.format[JsonOutputMessage]

    def jsonFromConcreteMessage[T <: Any](msg: OutputMessage[T]): JsValue = {
        Json.toJson(JsonOutputMessage(msg.companion.msgName, msg.toJson))
    }

    def jsonIllegalOperation(err: String, illegalRequestId: Long): JsValue = {
        val illegalOperation = IllegalOperation(err, illegalRequestId)
        jsonFromConcreteMessage(illegalOperation)
    }
}



