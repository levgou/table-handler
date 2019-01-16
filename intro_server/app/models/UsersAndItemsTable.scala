package models

import play.api.libs.json._

import scala.collection.mutable.ArrayBuffer

class UsersAndItemsTable(var uid: String, var name: String) {

    private val tableItemsList: ArrayBuffer[TableItem] = ArrayBuffer()
    private val userList: ArrayBuffer[TableUser] = ArrayBuffer()

    def addItemToTable(tableItem: TableItem): Int = {
        tableItemsList += tableItem
        1
    }

    def addUserToTable(tableUser: TableUser): Boolean = {
        if (userList.exists { user => user.name == tableUser.name })
            return false

        userList += tableUser
        true
    }

    def amount: Double = {
        tableItemsList.foldLeft(0.0) {
            (total, item) => total + item.price
        }
    }


}

object UsersAndItemsTable {

    def apply(uid: String, name: String, amount: Double,
              tableItemsList: ArrayBuffer[TableItem], userList: ArrayBuffer[TableUser]): UsersAndItemsTable = {

        val table = new UsersAndItemsTable(uid, name)
        table.tableItemsList ++= tableItemsList
        table.userList ++= userList
        table
    }

    def unapply(table: UsersAndItemsTable):
    Option[(String, String, Double, ArrayBuffer[TableItem], ArrayBuffer[TableUser])] = {
        Some((table.uid, table.name, table.amount, table.tableItemsList, table.userList))
    }

    implicit val tableFormat: OFormat[UsersAndItemsTable] = Json.format[UsersAndItemsTable]

}


case class TableItem(name: String, price: Double, itemId: Long = -1, itemUID: Long = -1)

object TableItem {
    implicit val tableItemFormat: OFormat[TableItem] = Json.format[TableItem]
}

case class TableUser(name: String)

object TableUser {
    implicit val tableUserFormat: OFormat[TableUser] = Json.format[TableUser]
}
