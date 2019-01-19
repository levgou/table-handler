package services

import akka.actor.{Actor, ActorLogging, ActorRef, Props}
import models.TableItem

import scala.collection.mutable
import scala.collection.mutable.ArrayBuffer

class TableActor(tableId: String) extends Actor with ActorLogging {

    private val BM = BusinessesManagement

    val tableItems: ArrayBuffer[TableItem] = mutable.ArrayBuffer.empty[TableItem]

    override def preStart(): Unit = log.info(s"Table [$tableId] opened")

    override def postStop(): Unit = log.info(s"Table [$tableId] closed")

    // No need to handle any messages
    override def receive = {
        case BM.AddItemToTable(businessId, _, item, requestUID) =>

            if (tableItems.exists(_.itemUID == item.itemUID))
                sender() ! BM.OperationOutcome(
                    status = false, s"Item with uid [${item.itemUID}] was already added to [$tableId]", requestUID)

            else {
                log.info(s"Adding [${item.name}] to [$tableId] in [$businessId]")
                tableItems += item
                sender() ! BM.OperationOutcome(status = true, "", requestUID)
            }

        case x: Any =>
            log.error(s"Unrecognized msg: ${x.toString}")
            sender() ! BM.IllegalOperation(
                s"TableActor: Couldn't match request - ${x.toString}", -1)
    }

}

object TableActor {
    def props(tableId: String): Props = Props(new TableActor(tableId))
}
