package com.wardbook

import grails.converters.JSON

class HelpersController {

    def consultants() {
        render User.consultants()*.name as JSON
    }

    def users() {
        def users = User.list().collectEntries { [it.id, it.name] }
        render users as JSON
    }
}
