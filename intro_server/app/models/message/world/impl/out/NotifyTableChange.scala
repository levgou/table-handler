package models.message.world.impl.out

import models.containeres.BusinessTable
import models.message.world.interfaces.out.{OutputMessage, OutputMessageCompanion}
import play.api.libs.json.{Json, OFormat}

case class NotifyTableChange(tableStatus: BusinessTable) extends OutputMessage[NotifyTableChange] {
    override def companion: OutputMessageCompanion[NotifyTableChange] = NotifyTableChange
}

object NotifyTableChange extends OutputMessageCompanion[NotifyTableChange] {
    override val msgName: String = "NotifyTableChange"
    override implicit val fmt: OFormat[NotifyTableChange] = Json.format[NotifyTableChange]
}