package controllers

import javax.inject.{Inject, Singleton}
import models._
import play.api.mvc._
import play.api.libs.json.{Json, OFormat}

@Singleton
class TableController @Inject()(cc: ControllerComponents) extends AbstractController(cc) {

    def get(id: Long) = Action {
        val table: UsersAndItemsTable = new UsersAndItemsTable("some_uid " + id, "some_name")

        table.addItemToTable(TableItem("a", 2))
        table.addItemToTable(TableItem("b", 3))
        table.addUserToTable(TableUser("MahName"))

        Ok(Json.toJson(table))
    }

    def save = Action(parse.json) { request =>
        val user = request.body.as[UsersAndItemsTable]
        println(Json.toJson(user))
        Created("User was created")
    }
}