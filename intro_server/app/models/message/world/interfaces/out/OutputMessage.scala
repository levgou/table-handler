package models.message.world.interfaces.out

import models.message.world.impl.out.IllegalOperation
import play.api.libs.json._
import services.MessageIdGenerator


abstract class OutputMessage[T](val requestId: Long = -1) {
    self: T =>

    val messageId: Long = MessageIdGenerator.genId()

    def companion: OutputMessageCompanion[T]
    val baseDetails = Json.toJsObject(Map("messageId"->messageId, "requestId" -> requestId))

    def toJson: JsValue = baseDetails.deepMerge(Json.toJsObject(this)(companion.fmt).as[JsObject])
}


abstract class OutputMessageCompanion[OT] {
    val msgName: String
    implicit val fmt: OFormat[OT]
}

