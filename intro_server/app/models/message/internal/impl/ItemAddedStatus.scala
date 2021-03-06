package models.message.internal.impl

import models.containeres.TableItem
import models.enums.ItemOper._
import models.message.internal.interfaces.InternalItemOperStatus


case class ItemAddedStatus(item: TableItem, status: Boolean, msg: String, requestId: Long)
    extends InternalItemOperStatus {
    override val oper: ItemOper = AddToTable
}
