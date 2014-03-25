package com.wardbook

class Contact {

    String name
    String phoneNumber

    static constraints = {
        name nullable: false
        phoneNumber nullable: false
    }
}
