package models.containeres

import org.scalactic.{Bad, ErrorMessage, Good, Or}

import scala.collection.mutable.ArrayBuffer

class ItemCart {
    var cartItems: Seq[TableItem] = Seq.empty
    val cartHistory: ArrayBuffer[Seq[TableItem]] = ArrayBuffer.empty


    def addItem(item: TableItem): TableItem Or ErrorMessage = {
        cartItems.find(_.id == item.id) match {
            case Some(_) => Bad(s"Item [${item.name}-${item.groupId}] already exists in cart")
            case None =>
                cartHistory += cartItems
                cartItems  = item +: cartItems
                Good(item)
        }
    }


    def removeItem(item: TableItem): TableItem Or ErrorMessage = {
        cartItems.find(_.groupId == item.groupId) match {
            case Some(foundItem) =>
                cartHistory += cartItems
                cartItems  = cartItems.filterNot(_.id == item.id)
                Good(foundItem)

            case None => Bad(s"No item [${item.name}-${item.groupId}] exists in car")
        }
    }
}

