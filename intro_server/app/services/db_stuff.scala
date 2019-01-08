package services


import org.mongodb.scala._

import scala.annotation.switch

/**
  * The db_stuff code example see: https://mongodb.github.io/mongo-scala-driver/2.0/getting-started
  */
object db_stuff {

    val onlineDbUri = "mongodb://webserver:q1w2e3@ds151354.mlab.com:51354/heroku_31bdrc2f"
    val offlineFromDockerComposeDbUri = "mongodb://db"
    val offlineFromIDEDbUri = "mongodb://localhost"


    val isOffline: Boolean = sys.env.get("OFFLINE_TABLE").isDefined
    val isIDE: Boolean = sys.env.get("IDE_TABLE").isDefined

    val actualDbUri: String = if (isOffline) offlineFromDockerComposeDbUri else if (isIDE) offlineFromIDEDbUri else onlineDbUri

    val mongoClient: MongoClient = MongoClient(actualDbUri)

    // get handle to "mydb" database
    val database: MongoDatabase = mongoClient.getDatabase("heroku_31bdrc2f")

    // get a handle to the first_c collection
    val collection: MongoCollection[Document] = database.getCollection("first_c")

}
