package models.containeres.info

import com.fasterxml.jackson.annotation.JsonIgnore
import play.api.libs.json.{Json, OFormat}

case class BusinessInfo(@JsonIgnore name: String, id: String) {
    def this(id: String) = this(id, id)
}

object BusinessInfo {
    implicit val fmt: OFormat[BusinessInfo] = Json.format[BusinessInfo]
    def apply(id: String): BusinessInfo =  apply(id, id)
}
