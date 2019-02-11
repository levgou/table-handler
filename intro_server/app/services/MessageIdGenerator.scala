package services

import java.util.concurrent.atomic.AtomicLong

object MessageIdGenerator {

    val currentId: AtomicLong = new AtomicLong(Math.pow(10, 6).toInt)
    def genId(): Long = currentId.incrementAndGet()
}
