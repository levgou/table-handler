package services

import akka.actor.{Actor, ActorRef, PoisonPill, Props}


class TableCustomerServiceActor(out: ActorRef) extends Actor {

    // return partial func to handle the messages ?
    override def receive: Receive = {

        case msg: String if msg.contains("close") =>
            out ! "Closing the connection as requested"
            self ! PoisonPill

        case msg: String =>
            out ! s"Echo, Received the message: $msg"
    }

    override def postStop() {
        println("Closing the websocket connection.")
    }
}


object TableCustomerServiceActor {
    // Props is a ActorRef configuration object, that is immutable, so it is thread safe and fully sharable.
    def props(out: ActorRef): Props = Props(new TableCustomerServiceActor(out))
}
