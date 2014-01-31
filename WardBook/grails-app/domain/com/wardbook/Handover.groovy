package com.wardbook

@gorm.AuditStamp
class Handover {

    static belongsTo = [from: User, to: User]

    static constraints = {
        to nullable: true
    }
}
