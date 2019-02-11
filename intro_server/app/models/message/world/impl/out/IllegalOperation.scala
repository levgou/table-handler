package models.message.world.impl.out


import models.message.world.interfaces.out.{OutputMessage, OutputMessageCompanion}
import play.api.libs.json.{Json, OFormat, OWrites, Writes}


final case class IllegalOperation(error: String, override val requestId: Long)
    extends OutputMessage[IllegalOperation] {

    override def companion: OutputMessageCompanion[IllegalOperation] = IllegalOperation
}

object IllegalOperation extends OutputMessageCompanion[IllegalOperation] {
    override val msgName: String = "IllegalOperation"
    override implicit val fmt: OFormat[IllegalOperation] = Json.format[IllegalOperation]
}

