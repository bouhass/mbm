package com.wardbook

class Contact {

    String name
    String phoneNumber
    String location

    static constraints = {
        name nullable: false
        phoneNumber nullable: false
        location nullable: true
    }
}
