package controllers

import akka.actor.ActorSystem
import akka.stream.Materializer
import com.google.inject.Singleton
import javax.inject.Inject
import models.actors.CustomerActor
import play.api.libs.json.JsValue
import play.api.libs.streams.ActorFlow
import play.api.mvc.{AbstractController, ControllerComponents, WebSocket}


@Singleton
class CustomerController @Inject()(cc: ControllerComponents)(implicit system: ActorSystem, mat: Materializer)
    extends AbstractController(cc) {

    def requestSocket(clientId: String): WebSocket = WebSocket.accept[JsValue, JsValue] { request =>

        ActorFlow.actorRef { out =>
            CustomerActor.props(out, clientId)
        }
    }

}
