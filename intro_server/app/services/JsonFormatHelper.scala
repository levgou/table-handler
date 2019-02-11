package services

import play.api.libs.json.{JsValue, Json, OFormat}


object Syntax {
    object json {
        implicit class JsonOps[T](val t: T) extends AnyVal {
            def toJson(implicit fmt: OFormat[T]): JsValue = Json.toJson(t)(fmt)
        }
    }
}
