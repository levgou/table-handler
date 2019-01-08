logLevel := Level.Warn

resolvers += "Typesafe repository" at " https://repo1.maven.org/maven2"
//resolvers += "Typesafe repository" at "https://https://dl.bintray.com/sbt/sbt-plugin-releases/"
//https://maven.atlassian.com/maven-external/com/typesafe/play/sbt-plugin_2.10_0.13

//resolvers += Resolver.typesafeRepo("releases")
//resolvers += Resolver.typesafeIvyRepo("https://https://dl.bintray.com/sbt/sbt-plugin-releases/")
//resolvers += "Typesafe repository" at
//    "http://repo.typesafe.com/typesafe/ivy-releases/"

//resolvers += "Typesafe Releases" at " https://repo1.maven.org/maven2/com/typesafe/play"
//
//resolvers += "Typesafe Simple Repository" at
//    "http://repo.typesafe.com/typesafe/simple/maven-releases/"

//resolvers += Resolver.url("Typesafe repository", url(" https://repo1.maven.org/maven2/com/typesafe/play"))(Resolver.mavenStylePatterns)


addSbtPlugin("com.typesafe.play" % "sbt-plugin" % "2.6.20")