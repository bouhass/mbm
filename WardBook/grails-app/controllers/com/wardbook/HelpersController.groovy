package com.wardbook

import grails.converters.JSON

class HelpersController {

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
