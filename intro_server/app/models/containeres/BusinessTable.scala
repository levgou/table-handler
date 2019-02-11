package models.containeres

import org.scalactic.{Bad, ErrorMessage, Good, Or}
import play.api.libs.json._


object BusinessTable {
    implicit val tableUserFormat: OFormat[BusinessTable] = Json.format[BusinessTable]
}


case class BusinessTable(id: String, items: Seq[TableItem] = Seq.empty) {

    def addItem(item: TableItem): BusinessTable Or ErrorMessage = {
        items.find(_.id == item.id) match {
            case Some(_) => Bad(s"Item with Id [${item.id}] already exists in table [$id]")
            case None => Good(this.copy(items = item +: this.items))
        }
    }

    def removeItem(item: TableItem): (BusinessTable, TableItem) Or ErrorMessage = {
        items.find(_.groupId == item.groupId) match {
            case Some(foundItem) => Good(
                this.copy(items = items.filterNot(_.id == foundItem.id)),
                foundItem)
            case None => Bad(s"No item with Id [${item.groupId}] exists in table [$id]")
        }
    }
}
