package controllers

import javax.inject.{Inject, Singleton}
import play.api.mvc._
import play.api.libs.json.{JsValue, Json}

import scala.concurrent.Await
import akka.pattern.ask
import akka.util.Timeout
import models.actors.{ActorWorld, BusinessActor, BusinessesManagementActor, TableActor}
import models.message.world.impl.out.{IllegalOperation, OperationOutcome}
import models.message.world.interfaces.in.{BusinessManagementMessage, BusinessMessage}

import scala.concurrent.duration._


@Singleton
class BusinessController @Inject()(cc: ControllerComponents) extends AbstractController(cc) {

    private implicit val timeout: Timeout = Timeout(5 seconds)

    private val BM = BusinessesManagementActor

    private val BA = BusinessActor

    private val TA = TableActor

    def openBusiness: Action[JsValue] = Action(parse.json) { request =>
        val openBizReq = request.body.asOpt[BM.OpenBusiness]
        handleIncomingBizMsg(openBizReq, "OpenBusiness", request.body.toString)
    }

    def openTable: Action[JsValue] = Action(parse.json) { request =>
        val openTblReq = request.body.asOpt[BA.OpenBusinessTable]
        handleIncomingBizMsg(openTblReq, "OpenBusinessTable", request.body.toString)
    }

    def addItemToTable: Action[JsValue] = Action(parse.json) { request =>
        val addItemReq = request.body.asOpt[TA.AddItemToTable]
        handleIncomingBizMsg(addItemReq, "AddItemToTable", request.body.toString)
    }

    private def handleIncomingBizMsg(bizMsgOption: Option[BusinessManagementMessage], msgType: String, reqBodyStr: String) = {
        bizMsgOption match {
            case Some(actualMsg) =>
                val future = ActorWorld.businesses ? actualMsg
                val result = Await.result(future, timeout.duration)
                _respond(result)
            case None => Ok(Json.toJson(Map(s"Incorrect Json format for $msgType" -> reqBodyStr)))
        }
    }


    def _respond[T](result: T): Result = result match {
        case operOutcome: OperationOutcome => Ok(Json.toJson(operOutcome))
        case illegalOper: IllegalOperation => Ok(Json.toJson(illegalOper))
        case _ => Ok(Json.toJson(Map("NoRegisteredJsonConverter" -> result.toString)))
    }
}
