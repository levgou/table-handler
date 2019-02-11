package models.message.world.impl.out

import models.message.world.interfaces.out.{OutputMessage, OutputMessageCompanion}
import play.api.libs.json.{Json, OFormat}


final case class OperationOutcome(status: Boolean, msg: String, override val requestId: Long)
    extends OutputMessage[OperationOutcome] {
    override def companion: OutputMessageCompanion[OperationOutcome] = OperationOutcome
}

object OperationOutcome extends OutputMessageCompanion[OperationOutcome] {
    override val msgName: String = "OperationOutcome"
    override implicit val fmt: OFormat[OperationOutcome] = Json.format[OperationOutcome]
}
