package com.wardbook

class ReferralList {

    String name
    static hasMany = [patients: Patient]

    static constraints = {
    }

    String toString() { "${name}" }
}
