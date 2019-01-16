package models

import play.api.libs.json.{Json, OFormat}


case class OpenTableRequest(businessId: String, tableId: String, requestUID: Long)

object OpenTableRequest {
    implicit val openBusinessRequestFormat: OFormat[OpenTableRequest] = Json.format[OpenTableRequest]
}

