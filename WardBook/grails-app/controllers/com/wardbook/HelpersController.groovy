package com.wardbook

import grails.converters.JSON

class HelpersController {

    def springSecurityService

    def consultants() {
        def consultants = User.consultants().collectEntries { [it.id, it.name] }
        render consultants as JSON
    }

    def users() {
        def users = User.list().collectEntries { [it.id, it.name] }
        render users as JSON
    }

    def wards() {
        def wards = Ward.list().collectEntries { [it.id, it.name] }
        render wards as JSON
    }

    def referralLists() {
        switch (request.method) {
            case 'GET':
                break
            case 'POST':
                def patient = Patient.get(params.pk)

                def tmp = []
                tmp.addAll(patient.referralLists)
                tmp.each { it.removeFromPatients(patient) }

                def newReferralLists = params['value[]']
                if (newReferralLists) {
                    if (!newReferralLists.class.isArray()) newReferralLists = [newReferralLists]
                    newReferralLists.each { patient.addToReferralLists(ReferralList.findByName(it)) }
                }

                render(status: 201)
        }
    }

    def switchWard() {
        request.user.referralList = null
            request.user.ward = Ward.get(params.'ward.id')
        if (!request.user.save(flush: true)) {
            render(status: 500, text: 'Failed to update ward')
        }
        else {
            render(status: 201, text: 'Successfully updated ward')
        }
    }

    def switchList() {
        request.user.ward = null
        request.user.referralList = ReferralList.get(params.'list.id')
        if (!request.user.save(flush: true)) {
            render(status: 500, text: 'Failed to update list')
        }
        else {
            render(status: 201, text: 'Successfully updated list')
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

    def authenticate() {
        if (request.user.password == springSecurityService.encodePassword(params.password)) {
            render(status: 201)
            return
        }

        render(status: 500)
    }

    def signOff() {
        def user1 = request.user
        def encodedPassword = springSecurityService.encodePassword(params.password)
//        def user2 = User.get(params.user2)
//        def encodedPassword2 = springSecurityService.encodePassword(params.password2)

        if (user1.password == encodedPassword /* && user2.password == encodedPassword2 */) {
            if (new Handover(from: user1 /*, to: user2 */).save(flush: true)) {
                render(status: 201)
                return
            }
        }

        render(status: 500)
    }
}
