package controllers

import akka.actor.ActorSystem
import akka.stream.Materializer
import com.google.inject.Singleton
import javax.inject.Inject
import play.api.libs.streams.ActorFlow
import play.api.mvc.{AbstractController, ControllerComponents, WebSocket}
import services.TableCustomerServiceActor

/**
  * Chat Controller instance that handles the incoming chat requests with the server and provides a Echo chat service.
  *
  */
@Singleton
class TableCustomerController @Inject()(cc: ControllerComponents)(implicit system: ActorSystem, mat: Materializer)
    extends AbstractController(cc) {


    def requestSocket(clientId: String, businessId: String, tableId: String): WebSocket =
        WebSocket.accept[String, String] { request =>

            // Create a flow that is handled by an actor
            // Accepts a function[ActorRef => Props] that creates the props for actor to handle the flow.
            ActorFlow.actorRef { out =>
                TableCustomerServiceActor.props(out, clientId, businessId, tableId)
            }
        }


    /*
     returns a web socket - that accepts strings and return strings
     WebSocket.accept receives a function(RequestHeader => Flow)
     */
    def socket: WebSocket = WebSocket.accept[String, String] { request =>

        // Create a flow that is handled by an actor
        // Accepts a function[ActorRef => Props] that creates the props for actor to handle the flow.
        ActorFlow.actorRef { out =>
            TableCustomerServiceActor.props(out, "Client", "B", "T")
        }
    }

}
