package models.enums

import models.enums
import play.api.libs.json.{Reads, Writes, Format}


object ItemOper extends Enumeration {
    type ItemOper = Value
    val MoveToCart, RemFromCart, AddToTable, RemFromTable = Value

    implicit val myEnumReads: Reads[enums.ItemOper.Value] = Reads.enumNameReads(ItemOper)
    implicit val myEnumWrites : Writes[enums.ItemOper.Value] = Writes.enumNameWrites

}

