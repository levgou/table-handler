name := "intro"

version := "1.0" 

logLevel := Level.Info
      
lazy val `intro` = (project in file(".")).enablePlugins(PlayScala)

resolvers += "scalaz-bintray" at "https://dl.bintray.com/scalaz/releases"
      
resolvers += "Akka Snapshot Repository" at "http://repo.akka.io/snapshots/"

resolvers += Resolver.typesafeRepo("releases")

scalaVersion := "2.12.6"

libraryDependencies ++= Seq( jdbc , ehcache , ws , specs2 % Test , guice)

libraryDependencies += "org.mongodb.scala" %% "mongo-scala-driver" % "2.5.0"


unmanagedResourceDirectories in Test <+=  baseDirectory ( _ /"target/web/public/test" )  

