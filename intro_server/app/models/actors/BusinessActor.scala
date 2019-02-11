package models.actors

import akka.actor.{Actor, ActorLogging, ActorRef, Props}
import models.containeres.info.{BusinessInfo, TableInfo}
import models.message.internal.interfaces.InternalTableMessage
import models.message.world.impl.out.{IllegalOperation, OperationOutcome}
import models.message.world.interfaces.in.{BusinessMessage, InputMessageCompanion, TableMessage}
import play.api.libs.json.{Json, OFormat}

import scala.collection.mutable


object BusinessActor {

    final case class OpenBusinessTable(businessId: String, tableInfo: TableInfo, messageId: Long) extends BusinessMessage

    final object OpenBusinessTable extends InputMessageCompanion[OpenBusinessTable] {
        override val msgName: String = "OpenBusinessTable"
        override implicit val fmt: OFormat[OpenBusinessTable] = Json.format[OpenBusinessTable]
    }


    def props(businessInfo: BusinessInfo): Props = Props(new BusinessActor(businessInfo))
}


class BusinessActor(businessInfo: BusinessInfo) extends Actor with ActorLogging {

    private val BA = BusinessActor
    private val AW = ActorWorld

    var openTables = mutable.HashMap.empty[String, ActorRef]


    override def preStart(): Unit = log.info(s"Business [$businessInfo] started")

    override def postStop(): Unit = log.info(s"Business [$businessInfo] stopped")

    override def receive: Receive = {

        case tm: TableMessage => openTables.get(tm.tableId) match {
            case None =>
                val err = s"Table [${tm.tableId}] is not open at at [$businessInfo]"
                log.error(err)
                sender() ! IllegalOperation(err, tm.messageId)

            case Some(tableActor) =>
                tableActor forward tm
        }

        // TODO: merge logic with above - REFACTOR
        case internalTM: InternalTableMessage => openTables.get(internalTM.tableId) match {
            case None =>
                val err = s"Table [${internalTM.tableId}] is not open at at [$businessInfo]"
                log.error(err)
                sender() ! IllegalOperation(err, internalTM.requestId)

            case Some(tableActor) =>
                tableActor forward internalTM
        }

        case BA.OpenBusinessTable(_, tableInfo, requestId) =>
            handleOpenTable(tableInfo, requestId)

        case x: Any =>
            log.error(s"Unrecognized msg: ${x.toString}")
            sender() ! IllegalOperation(s"BusinessActor: Couldn't match request - ${x.toString}", -1)
    }

    private def handleOpenTable(tableInfo: TableInfo, requestId: Long): Unit = openTables.get(tableInfo.id) match {

        case None =>
            log.info(s"Open table [$tableInfo] at [$businessInfo]")
            val tableActorRef = context.actorOf(TableActor.props(tableInfo), tableInfo.id)
            openTables(tableInfo.id) = tableActorRef
            sender() ! OperationOutcome(status = true, "", requestId)

        case Some(_) =>
            log.info(s"Actor already exists for $businessInfo - $tableInfo")
            sender() ! OperationOutcome(status = false, s"Table already open [$tableInfo] at [$businessInfo]", requestId)
    }


}

