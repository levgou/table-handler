name := "intro"
 
version := "1.0" 
      
lazy val `intro` = (project in file(".")).enablePlugins(PlayScala)

resolvers += "scalaz-bintray" at "https://dl.bintray.com/scalaz/releases"
      
resolvers += "Akka Snapshot Repository" at "http://repo.akka.io/snapshots/"

//resolvers += "Typesafe repository" at "https://repo.typesafe.com/typesafe/ivy-releases/"


scalaVersion := "2.12.2"

libraryDependencies ++= Seq( jdbc , ehcache , ws , specs2 % Test , guice)

libraryDependencies += "org.mongodb.scala" %% "mongo-scala-driver" % "2.5.0"

libraryDependencies += "com.typesafe.play" % "play-exceptions" % "2.6.20"


unmanagedResourceDirectories in Test <+=  baseDirectory ( _ /"target/web/public/test" )  

