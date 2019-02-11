package models.message.internal.interfaces


trait InternalBusinessMessage extends InternalBusinessManagementMessage {
    val businessId: String
}
