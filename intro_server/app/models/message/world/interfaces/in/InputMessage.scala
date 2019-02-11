package models.message.world.interfaces.in

import play.api.libs.json.OFormat

trait InputMessage {
    val messageId: Long
    val requestId: Long = -1
}

trait InputMessageCompanion[OT] {
    val msgName: String
    implicit val fmt: OFormat[OT]
}

