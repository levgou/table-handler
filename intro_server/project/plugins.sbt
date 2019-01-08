logLevel := Level.Warn

//resolvers += "Typesafe repository" at "https://repo.typesafe.com/typesafe/maven-releases/"
//resolvers += "Typesafe repository" at "https://https://dl.bintray.com/sbt/sbt-plugin-releases/"
//https://maven.atlassian.com/maven-external/com/typesafe/play/sbt-plugin_2.10_0.13

//resolvers += Resolver.typesafeRepo("releases")
//resolvers += Resolver.typesafeIvyRepo("https://https://dl.bintray.com/sbt/sbt-plugin-releases/")
resolvers += "Typesafe repository" at
    "http://repo.typesafe.com/typesafe/ivy-releases/"

//resolvers += "Typesafe Releases" at "https://repo.typesafe.com/typesafe/releases/"
//
//resolvers += "Typesafe Simple Repository" at
//    "http://repo.typesafe.com/typesafe/simple/maven-releases/"

resolvers += Resolver.url("Typesafe repository", url("http://repo.typesafe.com/typesafe/ivy-releases/"))(Resolver.ivyStylePatterns)


addSbtPlugin("com.typesafe.play" % "sbt-plugin" % "2.6.20")