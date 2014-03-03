package com.wardbook

@gorm.AuditStamp
class TeamList {

    String name
    static hasMany = [patients: Patient, users: User]

    static constraints = {
    }

    String toString() { "${name}" }
}
