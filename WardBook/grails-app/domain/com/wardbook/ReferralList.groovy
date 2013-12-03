package com.wardbook

@gorm.AuditStamp
class ReferralList {

    String name
    static hasMany = [patients: Patient, users: User]

    static constraints = {
    }

    String toString() { "${name}" }
}
