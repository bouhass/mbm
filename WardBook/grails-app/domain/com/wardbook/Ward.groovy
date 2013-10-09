package com.wardbook

@gorm.AuditStamp
class Ward {

    String name
    String speciality
    static hasMany = [patients: Patient, users: User]

    static constraints = {
    }

    String toString() { "${name} - ${speciality}" }
}
