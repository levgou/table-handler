package models.message.world.impl.out


import models.containeres.TableItem
import models.enums.ItemOper.ItemOper
import models.message.world.interfaces.out.{OutputMessage, OutputMessageCompanion}
import play.api.libs.json.{Json, OFormat}


case class ItemOperationStatus(item: TableItem, oper: ItemOper, status: Boolean, msg: String, override val requestId: Long)
    extends OutputMessage[ItemOperationStatus] {
    override def companion: OutputMessageCompanion[ItemOperationStatus] = ItemOperationStatus
}


object ItemOperationStatus extends OutputMessageCompanion[ItemOperationStatus] {
    override val msgName: String = "ItemOperationStatus"
    override implicit val fmt: OFormat[ItemOperationStatus] = Json.format[ItemOperationStatus]
}


