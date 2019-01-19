package controllers

import javax.inject.{Inject, Singleton}
import models._
import play.api.mvc._
import play.api.libs.json.{Json, OFormat}
import services.{ActorWorld, BusinessesManagement}

import scala.concurrent.Await
import akka.pattern.ask
import akka.util.Timeout
import services.BusinessesManagement.{IllegalOperation, OperationOutcome}

import scala.concurrent.duration._

@Singleton
class BusinessController @Inject()(cc: ControllerComponents) extends AbstractController(cc) {

    private implicit val timeout: Timeout = Timeout(5 seconds)

    private val BM = BusinessesManagement


    def openBusiness = Action(parse.json) { request =>

        val openBsReq = request.body.as[OpenBusinessRequest]
        val future = ActorWorld.businesses ? BM.OpenBusiness(openBsReq.businessId, openBsReq.requestUID)
        val result = Await.result(future, timeout.duration)

        _respond(result)
    }

    def openTable = Action(parse.json) { request =>

        val openTblReq = request.body.as[OpenTableRequest]
        val future = ActorWorld.businesses ?
            BM.OpenBusinessTable(openTblReq.businessId, openTblReq.tableId, openTblReq.requestUID)

        val result = Await.result(future, timeout.duration)

        _respond(result)
    }

    def addItemToTable= Action(parse.json) { request =>

        val addItemReq = request.body.as[AddItemToTableRequest]
        val future = ActorWorld.businesses ?
            BM.AddItemToTable(addItemReq.businessId, addItemReq.tableId, addItemReq.tableItem, addItemReq.requestUID)

        val result = Await.result(future, timeout.duration)

        _respond(result)
    }

    def _respond[T](result: T): Result = result match {
        case operOutcome @ OperationOutcome(_, _, _) => Ok(Json.toJson(operOutcome))
        case illegalOper @ IllegalOperation(_, _) => Ok(Json.toJson(illegalOper))
        case _ => Ok(Json.toJson(Map("NoRegisteredJsonConverter" -> result.toString)))
    }
}
