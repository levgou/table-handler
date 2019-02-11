package models.message.internal.interfaces

import models.containeres.TableItem
import models.enums.ItemOper.ItemOper

trait InternalItemOperStatus extends InternalMessage {
    val item: TableItem
    val oper: ItemOper
    val status: Boolean
    val msg: String
    val requestId: Long
}
