package models.actors

import akka.actor.{Actor, ActorLogging, ActorRef, Props}
import models.actors.TableActor.{RemItemFromTable, ReturnItemToTable}
import models.containeres.{ItemCart, TableItem}
import models.enums.ItemOper._
import models.message.internal.interfaces.{InternalItemOperStatus, InternalMessage}
import models.message.world.impl.in.{ItemOperationRequest, JsonInputMessage}
import models.message.world.impl.out.{ItemOperationStatus, JsonOutputMessage}
import models.message.world.interfaces.in.{BusinessMessage, InputMessage}
import models.message.world.interfaces.out.OutputMessage
import org.scalactic.{Bad, Good}
import play.api.libs.json.JsValue
import services.InputMessageMapper


object CustomerActor {
    def props(out: ActorRef, clientId: String): Props = {
        Props(new CustomerActor(out, clientId))
    }
}


// TODO: add support for shutdown of customer
class CustomerActor(out: ActorRef, clientId: String) extends Actor with ActorLogging{

    private val AW = ActorWorld

    private val cart = new ItemCart()


    override def receive: Receive = {

        case jsMsg: JsValue => handleCustomerJsMsg(jsMsg) // from world
        case outputMessage: OutputMessage[Any] => out ! JsonOutputMessage.jsonFromConcreteMessage(outputMessage)
        case internalMessage: InternalMessage => handleInternalMsg(internalMessage)
        case _ => sender() ! JsonOutputMessage.jsonIllegalOperation("Not supported format!", -1)
    }


    private def handleInternalMsg(internalMessage: InternalMessage): Unit = {
        internalMessage match {
            case internalItemOperStatus: InternalItemOperStatus => handleItemOperOutcome(internalItemOperStatus)
            case _ => log.error(s"Cannot handle message: $internalMessage")
        }
    }


    def handleMoveItemToCart(item: TableItem, requestId: Long): Unit = {
        log.info(s"Adding [${item.name}-${item.id}] to cart")
        cart.addItem(item) match {
            case Bad(err) =>
                log.error(err)
                out ! JsonOutputMessage.jsonFromConcreteMessage(ItemOperationStatus(item, MoveToCart, status = false, err, requestId))
            case Good(tableItem) =>
                log.info(s"Successfully moved item to cart [$tableItem]")
                out ! JsonOutputMessage.jsonFromConcreteMessage(ItemOperationStatus(tableItem, MoveToCart, status = true, "", requestId))
        }
    }


    def handleFailedMoveItemToCart(internalItemOperStatus: InternalItemOperStatus): Unit = {
        val sts = internalItemOperStatus
        log.warning(s"Failed in moving item to cart [${sts.item.name}-${sts.item.id}]")
        out ! JsonOutputMessage.jsonFromConcreteMessage(ItemOperationStatus(sts.item, MoveToCart, status = false, sts.msg, sts.requestId))
    }


    def handleRemItemFromCart(item: TableItem, requestId: Long): Unit = {
        log.info(s"Removing [${item.name}-${item.id}] from cart")
        cart.removeItem(item) match {
            case Bad(err) =>
                log.error(err)
                out ! JsonOutputMessage.jsonFromConcreteMessage(ItemOperationStatus(item, RemFromCart, status = false, err, requestId))
            case Good(tableItem) =>
                log.info(s"Successfully removed item from cart [$tableItem]")
                out ! JsonOutputMessage.jsonFromConcreteMessage(ItemOperationStatus(tableItem, RemFromCart, status = true, "", requestId))
        }
    }


    def handleFailedRemItemFromCart(internalItemOperStatus: InternalItemOperStatus): Unit = {
        val sts = internalItemOperStatus
        log.warning(s"Failed in removing item from cart [${sts.item.name}-${sts.item.id}]")
        out ! ItemOperationStatus(sts.item, RemFromCart, status = false, sts.msg, sts.requestId).toJson
    }


    def handleItemOperOutcome(internalItemOperStatus: InternalItemOperStatus): Unit = {
        val sts = internalItemOperStatus

        (sts.oper, sts.status) match {
            case (RemFromTable, true) =>    // this should happen as a result of move to cart
                handleMoveItemToCart(sts.item, sts.requestId)
            case (RemFromTable, false) =>
                handleFailedMoveItemToCart(sts)

            case (AddToTable, true) =>      // this should happen as a result of returning from cart to table
                handleRemItemFromCart(sts.item, sts.requestId)
            case (AddToTable, false) =>
                handleFailedRemItemFromCart(sts)

            case (otherOper, _) =>
                log.error(s"No ability to handle item oper [$otherOper]: $sts")
        }
    }


    private def handleCustomerJsMsg(jsMsg: JsValue): Unit = {

        jsMsg.asOpt[JsonInputMessage] match {

            case Some(JsonInputMessage(inMessageType, msg)) =>
                val realizedMsg = InputMessageMapper.newFromJson(inMessageType, msg)

                realizedMsg match {
                    case Some(inputMessage) => handleActualInputMsg(inputMessage, inMessageType)
                    case None => out ! JsonOutputMessage.jsonIllegalOperation(
                        s"Incorrect msg structure for type [$inMessageType] - $msg", -1)
                }

            case None => out ! JsonOutputMessage.jsonIllegalOperation(s"Unsupported json fmt - $jsMsg", -1)
        }
    }


    private def handleActualInputMsg(inputMessage: InputMessage, inMessageType: String): Unit = {
        inputMessage match {
            case itemOperationRequest: ItemOperationRequest => handleItemOperRequest(itemOperationRequest)

            case businessMessage: BusinessMessage => AW.businesses ! businessMessage

            case _ => sender() ! JsonOutputMessage.jsonIllegalOperation(
                s"[$this] no support for msg of type [$inMessageType]", -1)
        }
    }


    private def handleItemOperRequest(itemOperationRequest: ItemOperationRequest): Unit = {
        val req = itemOperationRequest
        req.operation match {
            case MoveToCart => AW.businesses ! RemItemFromTable(req.businessId, req.tableId, req.item, req.messageId)
            case RemFromCart => AW.businesses ! ReturnItemToTable(req.businessId, req.tableId, req.item, req.messageId)

            case _ => JsonOutputMessage.jsonIllegalOperation(
                s"Not supported Operation [$req]!", itemOperationRequest.messageId)
        }
    }


    override def postStop() {
        println("Closing the websocket connection.")
    }
}

