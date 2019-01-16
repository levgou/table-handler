package services

import akka.actor.{Actor, ActorLogging, ActorRef, Props}

import scala.collection.mutable

class BusinessActor(businessId: String) extends Actor with ActorLogging {

    private val BM = BusinessesManagement
    
    var openTables = mutable.HashMap.empty[String, ActorRef]

    override def preStart(): Unit = log.info(s"Business [$businessId] started")

    override def postStop(): Unit = log.info(s"Business [$businessId] stopped")

    override def receive: Receive = {
        case BM.OpenBusinessTable(businessId_, tableId, requestUID) =>
            // TODO: move this to a func
            openTables.get(tableId) match {
                case None =>
                    log.info(s"Open table [$tableId] at [$businessId_]")
                    val tableActorRef = context.actorOf(TableActor.props(tableId), tableId)
                    openTables += (tableId -> tableActorRef)
                    sender() ! BM.OperationOutcome(status = true, "", requestUID)

                case Some(_) =>
                    log.info(s"Actor already exists for $businessId_ - $tableId")
                    sender() ! BM.OperationOutcome(status = false, s"Table already open [$tableId] at [$businessId_]", requestUID)
            }

        case addItemMsg @  BM.AddItemToTable(businessId_, tableId, _, requestUID)=>
            openTables.get(tableId) match {
                case None =>
                    val err = s"Table [$tableId] is not open at at [$businessId_]"
                    log.error(err)
                    sender() ! BM.IllegalOperation(err, requestUID)

                case Some(tableActor) =>
                    tableActor forward addItemMsg
            }


        case x: Any =>
            log.error(s"Unrecognized msg: ${x.toString}")
            sender() ! BM.IllegalOperation(
                s"BusinessActor: Couldn't match request - ${x.toString}", -1)
    }

}

object BusinessActor {
    def props(businessId: String): Props = Props(new BusinessActor(businessId))
}
