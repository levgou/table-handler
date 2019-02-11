package models.actors

import akka.actor.{Actor, ActorLogging, ActorRef, Props}
import akka.util.Timeout
import models.containeres.info.BusinessInfo
import models.message.internal.interfaces.InternalBusinessMessage
import models.message.world.impl.out.{IllegalOperation, OperationOutcome}
import models.message.world.interfaces.in.{BusinessManagementMessage, BusinessMessage, InputMessageCompanion}
import play.api.libs.json.{Json, OFormat}

import scala.collection.mutable
import scala.concurrent.duration._

object BusinessesManagementActor {

    final case class OpenBusiness(businessInfo: BusinessInfo, messageId: Long) extends BusinessManagementMessage

    final object OpenBusiness extends InputMessageCompanion[OpenBusiness] {
        override val msgName: String = "OpenBusiness"
        override implicit val fmt: OFormat[OpenBusiness] = Json.format[OpenBusiness]
    }

    final case class CloseBusiness(businessInfo: BusinessInfo, messageId: Long) extends BusinessManagementMessage

    final object CloseBusiness extends InputMessageCompanion[CloseBusiness] {
        override val msgName: String = "CloseBusiness"
        override implicit val fmt: OFormat[CloseBusiness] = Json.format[CloseBusiness]
    }

    def props(): Props = Props(new BusinessesManagementActor)
}


class BusinessesManagementActor extends Actor with ActorLogging {

    private val BM = BusinessesManagementActor
    private val AW = ActorWorld

    private implicit val timeout: Timeout = Timeout(5 seconds)

    var openBusinesses = mutable.HashMap.empty[String, ActorRef]

    override def preStart(): Unit = log.info("BusinessesManagement Application started")

    override def postStop(): Unit = log.info("BusinessesManagement Application stopped")

    override def receive: Receive = {

        case bm: BusinessMessage =>

            openBusinesses.get(bm.businessId) match {
                case None =>
                    log.error(s"Business is not open: [${bm.businessId}]")
                    sender() ! IllegalOperation(s"Business is not open: ${bm.businessId}", bm.messageId)

                case Some(businessActor) =>
                    businessActor forward bm
        }

        // TODO: refactor and merge with above logic
        case ibm: InternalBusinessMessage => openBusinesses.get(ibm.businessId) match {
            case None =>
                log.error(s"Business is not open: [${ibm.businessId}]")
                sender() ! IllegalOperation(s"Business is not open: ${ibm.businessId}", ibm.requestId)

            case Some(businessActor) =>
                businessActor forward ibm
        }

        case BM.OpenBusiness(businessInfo, requestId) =>
            handleOpenBusiness(businessInfo, requestId)

        case BM.CloseBusiness(businessInfo, requestId) =>
            // TODO: impl
            sender() ! OperationOutcome(status = true, "", requestId)

        case x: Any =>
            log.error(s"Unrecognized msg: ${x.toString}")
            sender() ! IllegalOperation(
                s"BusinessManagementActor: Couldn't match request - ${x.toString}", -1)

    }


    private def handleOpenBusiness(businessInfo: BusinessInfo, requestId: Long): Unit = {

        openBusinesses.get(businessInfo.id) match {
            case None =>
                log.info(s"Creating actor for [$businessInfo]")

                val businessActorRef = context.actorOf(BusinessActor.props(businessInfo), businessInfo.id)
                openBusinesses += (businessInfo.id -> businessActorRef)
                sender() ! OperationOutcome(status = true, "", requestId)

            case Some(_) =>
                log.info(s"Actor already exists for $businessInfo")
                sender() ! OperationOutcome(status = false, s"Already Open - $businessInfo", requestId)
        }
    }

}
