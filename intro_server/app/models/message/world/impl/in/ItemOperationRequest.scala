package models.message.world.impl.in

import models.containeres.TableItem
import models.enums.ItemOper.ItemOper
import models.message.world.interfaces.in.{InputMessageCompanion, TableMessage}
import play.api.libs.json.{Json, OFormat}


case class ItemOperationRequest(businessId: String, tableId: String, item: TableItem, operation: ItemOper, messageId: Long)
    extends TableMessage


object ItemOperationRequest extends InputMessageCompanion[ItemOperationRequest] {
    override val msgName: String = "ItemOperationRequest"
    override implicit val fmt: OFormat[ItemOperationRequest] = Json.format[ItemOperationRequest]
}
