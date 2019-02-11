package models.containeres

import play.api.libs.json.{Json, OFormat}

case class TableItem(name: String, price: Double, groupId: Long = -1, id: Long = -1)

object TableItem {
    implicit val tableItemFormat: OFormat[TableItem] = Json.using[Json.WithDefaultValues].format[TableItem]
}
