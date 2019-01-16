package models

import play.api.libs.json.{Json, OFormat}


case class AddItemToTableRequest(businessId: String, tableId: String, tableItem: TableItem, requestUID: Long) {

}

object AddItemToTableRequest {
    implicit val addItemToTableRequestFormat: OFormat[AddItemToTableRequest] = Json.format[AddItemToTableRequest]
}

