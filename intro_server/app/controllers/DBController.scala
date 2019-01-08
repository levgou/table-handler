package controllers

import javax.inject.{Inject, Singleton}
import play.api.mvc._
import play.api.libs.json.{Json, OFormat}
import services.db_stuff

import org.mongodb.scala._

import services.Helpers._

@Singleton
class DBController @Inject()(cc: ControllerComponents) extends AbstractController(cc) {

    def get(param: String) = Action {
        val new_name = s"MongoDD_$param"
        val insert_res = db_stuff.collection.insertOne(Document("name" -> new_name, "type" -> "database")).results()
        val res = db_stuff.collection.find().results()
        val last_added = res.last.toString()

        //        db_stuff.mongoClient.close()

        Ok(Json.toJson("last added: " -> last_added))
    }

}
