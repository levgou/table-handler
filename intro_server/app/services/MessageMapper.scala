package services

import java.lang.reflect.Modifier

import models.message.world.interfaces.in.{InputMessage, InputMessageCompanion}
import org.reflections.Reflections
import play.api.libs.json.JsValue

import scala.collection.JavaConverters._
import scala.reflect.ClassTag
import scala.reflect.runtime.universe
import scala.util.Try


abstract class ClassMapper[T](packagePath: String)(implicit ttag: ClassTag[T]) {

    private def myClassOf[U: ClassTag] = implicitly[ClassTag[U]].runtimeClass

    private val reflections = new Reflections(packagePath)
    private val allAttributeClasses = reflections.getSubTypesOf(myClassOf[T]).asScala
    private val concreteAttributeClasses = allAttributeClasses filter { klass =>
        !Modifier.isAbstract(klass.getModifiers)
    }


    private val runtimeMirror = universe.runtimeMirror(getClass.getClassLoader)

    // TODO: this for possible future impl

    //    implicit val NameClassMap: Map[String, Class[T]] = (concreteAttributeClasses map { klass =>
    //        val module = runtimeMirror.staticModule(klass.getName)
    //        val companionObj = runtimeMirror.reflectModule(module).instance.asInstanceOf[fff]
    //        companionObj.orgName -> klass
    //    }).toMap

    private implicit val NameCompanionMap: Map[String, InputMessageCompanion[T]] =
        (for {
            klass <- concreteAttributeClasses
            module = runtimeMirror.staticModule(klass.getName)
            companion: Try[InputMessageCompanion[T]] = Try(runtimeMirror.reflectModule(module).instance.asInstanceOf[InputMessageCompanion[T]])
            if companion.isSuccess
        } yield companion.get.msgName -> companion.get).toMap

    // TODO: this for possible future impl

    //    def newFromName(name: String, value: String)
    //                   (implicit nameClassMap: Map[String, Class[_ <: T]]): T = {
    //        nameClassMap.get(name) match {
    //            case Some(klass) =>
    //                klass.getDeclaredConstructor(classOf[String]).newInstance(value)
    //            case None =>
    //                SubClass1("asdasdasd")
    //        }
    //    }


    def newFromJson(name: String, jsonRepr: JsValue): Option[T] = {

        NameCompanionMap.get(name) match {
            case Some(klass) =>
                jsonRepr.asOpt[T](klass.fmt)
            case None => None
        }
    }
}


object InputMessageMapper extends ClassMapper[InputMessage]("models")
