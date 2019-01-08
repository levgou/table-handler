logLevel := Level.Warn

//resolvers += "Typesafe repository" at "http://repo.typesafe.com/typesafe/releases/"
//https://maven.atlassian.com/maven-external/com/typesafe/play/sbt-plugin_2.10_0.13

resolvers += Resolver.typesafeRepo("releases")

addSbtPlugin("com.typesafe.play" % "sbt-plugin" % "2.6.20")