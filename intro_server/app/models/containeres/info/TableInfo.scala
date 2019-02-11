package models.containeres.info

import com.fasterxml.jackson.annotation.JsonIgnore
import play.api.libs.json.{Json, OFormat}

case class TableInfo(@JsonIgnore name: String, id: String) {
    def this(id: String) = this(id, id)
}

object TableInfo {
    implicit val fmt: OFormat[TableInfo] = Json.format[TableInfo]
    def apply(id: String): TableInfo = new TableInfo(id)
}


