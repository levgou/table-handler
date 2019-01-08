logLevel := Level.Warn

resolvers += "Typesafe repository" at "https://repo.typesafe.com/typesafe/maven-releases/"
//https://maven.atlassian.com/maven-external/com/typesafe/play/sbt-plugin_2.10_0.13

//resolvers += Resolver.typesafeRepo("releases")
//resolvers += Resolver.typesafeIvyRepo("releases")


addSbtPlugin("com.typesafe.play" % "sbt-plugin" % "2.6.20")