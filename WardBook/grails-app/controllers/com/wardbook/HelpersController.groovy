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

    def wards() {
        def wards = Ward.list().collectEntries { [it.id, it.name] }
        render wards as JSON
    }

    def switchWard() {
        request.user.ward = Ward.get(params.'ward.id')
        if (!request.user.save(flush: true)) {
            render(status: 500, text: 'Failed to update ward')
        }
        else {
            render(status: 201, text: 'Successfully updated ward')
        }
    }

    def setOnCallStatus() {
        request.user.onCall = Boolean.valueOf(params.onCall)
        if (!request.user.save(flush: true)) {
            render(status: 500, text: 'Failed to update on call status')
        }
        else {
            render(status: 201, text: 'Successfully updated on call status')
        }
    }
}
