package models.actors

import akka.actor.{ActorRef, ActorSystem}
import services.TableBusinessMapper


object ActorWorld {

    val system = ActorSystem("ActorWorld")
    val businesses: ActorRef = system.actorOf(BusinessesManagementActor.props(), "businesses")
}
