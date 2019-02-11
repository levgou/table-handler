package models.actors

import akka.actor.{Actor, ActorLogging, ActorRef, Props}
import models.containeres.info.{BusinessInfo, TableInfo}
import models.message.world.impl.out.{IllegalOperation, NotifyTableChange, OperationOutcome}
import models.message.world.interfaces.in.{InputMessageCompanion, TableMessage}
import models.containeres.{BusinessTable, TableItem}
import models.message.internal.impl.{ItemAddedStatus, ItemRemovedStatus}
import models.message.internal.interfaces.InternalTableMessage
import org.scalactic.{Bad, ErrorMessage, Good, Or}
import play.api.libs.json.{Json, OFormat}

import scala.collection.mutable
import scala.collection.mutable.ArrayBuffer


object TableActor {

    final case class AddItemToTable(businessId: String, tableId: String, item: TableItem, messageId: Long) extends TableMessage


    final object AddItemToTable extends InputMessageCompanion[AddItemToTable] {
        override val msgName: String = "AddItemToTable"
        override implicit val fmt: OFormat[AddItemToTable] = Json.format[AddItemToTable]
    }


    final case class RegisterForTableUpdates(businessId: String, tableId: String, messageId: Long) extends TableMessage


    final object RegisterForTableUpdates extends InputMessageCompanion[RegisterForTableUpdates] {
        override val msgName: String = "RegisterForTableUpdates"
        override implicit val fmt: OFormat[RegisterForTableUpdates] = Json.format[RegisterForTableUpdates]
    }


    final case class RemItemFromTable(businessId: String, tableId: String, item: TableItem, requestId: Long) extends InternalTableMessage


    final case class ReturnItemToTable(businessId: String, tableId: String, item: TableItem, requestId: Long) extends InternalTableMessage


    def props(tableInfo: TableInfo): Props = Props(new TableActor(tableInfo))
}


class TableActor(tableInfo: TableInfo) extends Actor with ActorLogging {

    private val TA = TableActor

    var tableStatus: BusinessTable = BusinessTable(tableInfo.id)
    val tableStatusHistory: ArrayBuffer[BusinessTable] = ArrayBuffer.empty

    val usersToNotify: ArrayBuffer[ActorRef] = mutable.ArrayBuffer.empty


    override def preStart(): Unit = log.info(s"Table [$tableInfo] opened")


    override def postStop(): Unit = log.info(s"Table [$tableInfo] closed")


    override def receive: Receive = {
        case TA.AddItemToTable(businessId, _, item, requestId) =>
            handleAddItemToTable(businessId, item, requestId)

        case TA.RemItemFromTable(businessId, _, item, requestId) =>
            handleRemItemFromTable(businessId, item, requestId)

        case TA.ReturnItemToTable(businessId, _, item, requestId) =>
            handleReturnItemToTable(businessId, item, requestId)

        case TA.RegisterForTableUpdates(businessId, _, requestId) =>
            handleRegisterForTableUpdates(sender(), businessId, requestId)

        case x: Any =>
            log.error(s"Unrecognized msg: ${x.toString}")
            sender() ! IllegalOperation(
                s"TableActor: Couldn't match request - ${x.toString}", -1)
    }


    private def handleAddItemToTable(businessId: String, item: TableItem, requestId: Long): Unit = {
        doAddItemToTable(item, businessId) match {
            case Bad(err) => sender() ! OperationOutcome(status = false, err, requestId)

            case Good(_) =>
                sender() ! OperationOutcome(status = true, "", requestId)
                notifyUsersWithTableUpdate()
        }
    }


    private def doAddItemToTable(item: TableItem, businessId: String): BusinessTable Or ErrorMessage = {
        val addOr = tableStatus.addItem(item)
        addOr match {
            case Good(newTableStatus) =>
                tableStatusHistory += tableStatus
                tableStatus = newTableStatus
                log.info(s"Added [${item.name}-${item.id}] to [$tableInfo] in [$businessId]")
        }
        addOr
    }


    private def handleReturnItemToTable(businessId: String, item: TableItem, requestId: Long): Unit = {
        log.info(s"Returning [${item.name}-${item.id}] to [$tableInfo] in [$businessId]")
        doAddItemToTable(item, businessId) match {
            case Bad(err) => sender() ! ItemAddedStatus(item, status = false, err, requestId)

            case Good(_) =>
                sender() ! ItemAddedStatus(item, status = true, "", requestId)
                notifyUsersWithTableUpdate()
        }
    }


    private def handleRemItemFromTable(businessId: String, item: TableItem, requestId: Long): Unit = {
        tableStatus.removeItem(item) match {
            case Bad(err) => sender() ! ItemRemovedStatus(item, status = false, err, requestId)

            case Good((newTableStatus, removedItem)) =>
                tableStatusHistory += tableStatus
                tableStatus = newTableStatus

                log.info(s"Removed [${removedItem.name}-${removedItem.id}] from [$tableInfo] in [$businessId]")
                sender() ! ItemRemovedStatus(removedItem, status = true, "", requestId)
                notifyUsersWithTableUpdate()
        }
    }


    private def handleRegisterForTableUpdates(userToNotify: ActorRef, businessId: String, requestId: Long): Unit = {

        if (usersToNotify.contains(userToNotify))
            sender() ! OperationOutcome(
                status = false, s"User [$ActorRef] already registered for events", requestId)

        else {
            log.info(s"Registering [$ActorRef] for events of [$tableInfo] in [$businessId]")
            usersToNotify += userToNotify
            sender() ! OperationOutcome(status = true, "", requestId)
            sender() ! NotifyTableChange(tableStatus)
        }
    }


    private def notifyUsersWithTableUpdate(): Unit = {
        usersToNotify.foreach(_ ! NotifyTableChange(tableStatus))
    }
}
