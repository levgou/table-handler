package models

import play.api.libs.json.{Json, OFormat}


case class OpenBusinessRequest(businessId: String, requestUID: Long) {

}

object OpenBusinessRequest {
    implicit val openBusinessRequestFormat: OFormat[OpenBusinessRequest] = Json.format[OpenBusinessRequest]
}

