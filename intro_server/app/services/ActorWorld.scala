package services

import akka.actor.{Actor, ActorLogging, ActorRef, ActorSystem, PoisonPill, Props}
import models.TableItem
import play.api.libs.json.{JsValue, Json, OFormat}

import scala.collection.mutable

object TableCustomerServiceActor {
    // Props is a ActorRef configuration object, that is immutable, so it is thread safe and fully sharable.
    def props(out: ActorRef, clientId: String, businessId: String, tableId: String): Props = {
        Props(new TableCustomerActor(
            out,
            SocketInfo(clientId, businessId, tableId)
        ))
    }
}


class TableCustomerServiceActor extends Actor {

    // return partial func to handle the messages ?
    override def receive: Receive = {

        case msg: String if msg.contains("close") =>
            println("Closing the connection as requested")
            self ! PoisonPill

        case msg: String =>
            println(s"$self - got -> $msg")

    }

    override def postStop() {
        println("Closing the websocket connection.")
    }
}


object BusinessesManagement {

    def props(): Props = Props(new BusinessesManagement)

    // misc
    final case class IllegalOperation(error: String, illegalRequestId: Long)

    final case class OperationOutcome(status: Boolean, msg: String, requestUID: Long)


    // businesses

    final case class OpenBusiness(businessId: String, requestUID: Long)

    final case class CloseBusiness(businessId: String, requestUID: Long)

    // tables
    final case class OpenBusinessTable(businessId: String, tableId: String, requestUID: Long)

    // items
    final case class AddItemToTable(businessId: String, tableId: String, item: TableItem, requestUID: Long)


    // formats
    implicit val operOutcomeFormat: OFormat[OperationOutcome] = Json.format[OperationOutcome]
    implicit val illegalOperFormat: OFormat[IllegalOperation] = Json.format[IllegalOperation]


}


class BusinessesManagement extends Actor with ActorLogging {

    private val BM = BusinessesManagement

    var openBusinesses = mutable.HashMap.empty[String, ActorRef]

    override def preStart(): Unit = log.info("BusinessesManagement Application started")

    override def postStop(): Unit = log.info("BusinessesManagement Application stopped")

    override def receive: Receive = {

        case BM.OpenBusiness(businessId, requestUID) =>
            // TODO: move this to a func
            openBusinesses.get(businessId) match {
                case None =>
                    log.info(s"Creating actor for [$businessId]")
                    val businessActorRef = context.actorOf(BusinessActor.props(businessId), businessId)
                    openBusinesses += (businessId -> businessActorRef)
                    sender() ! BM.OperationOutcome(status = true, "", requestUID)

                case Some(_) =>
                    log.info(s"Actor already exists for $businessId")
                    sender() ! BM.OperationOutcome(status = false, s"Already Open - $businessId", requestUID)
            }


        case BM.CloseBusiness(businessId, requestUID) =>
            sender() ! BM.OperationOutcome(status = true, "", requestUID)


        case openTableMsg @ BM.OpenBusinessTable(businessId, tableId, requestUID) =>
            openBusinesses.get(businessId) match {
                case None =>
                    log.error(s"Cannot open table [$tableId], because business [$businessId] is not open")
                    sender() ! BM.IllegalOperation(s"Business is not open: $businessId", requestUID)

                case Some(businessActor) =>
                    businessActor forward openTableMsg
            }

        case addItemMsg @ BM.AddItemToTable(businessId, _, _, requestUID) =>
            openBusinesses.get(businessId) match {
                case None =>
                    log.error(s"Cannot cannot add items because [$businessId] is not open")
                    sender() ! BM.IllegalOperation(s"Business is not open: $businessId", requestUID)

                case Some(businessActor) =>
                    businessActor forward addItemMsg
            }



        case x: Any =>
            log.error(s"Unrecognized msg: ${x.toString}")
            sender() ! BM.IllegalOperation(
                s"BusinessActor: Couldn't match request - ${x.toString}", -1)

    }

}


object ActorWorld {

    val system = ActorSystem("ActorWorld")
    val businesses: ActorRef = system.actorOf(BusinessesManagement.props(), "businesses")

}
