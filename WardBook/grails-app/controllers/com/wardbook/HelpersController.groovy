package com.wardbook

import grails.converters.JSON

class HelpersController {

    def springSecurityService

    def consultants() {
        render User.consultants()*.name as JSON
    }

    def users() {
        def users = User.list().collectEntries { [it.id, it.name] }
        render users as JSON
    }

    def switchWard() {
        def currentUser = springSecurityService.currentUser
        currentUser.ward = Ward.get(params.'ward.id')
        if (!currentUser.save(flush: true)) {
            render(status: 500, text: 'Failed to update ward')
        }
        else {
            render(status: 201, text: 'Successfully updated ward')
        }
    }
}
