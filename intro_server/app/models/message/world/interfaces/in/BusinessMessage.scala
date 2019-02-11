package models.message.world.interfaces.in

trait BusinessMessage extends BusinessManagementMessage {
    val businessId: String
}
