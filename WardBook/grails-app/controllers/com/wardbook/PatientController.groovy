package com.wardbook

import grails.converters.JSON

class PatientController {

    static scaffold = true

    def index() {
        redirect(action:handover)
    }

    def handover = {
        [patients: wardPatients()]
    }

    def joblist = {
        [patients: wardPatients()]
    }

    def profile() {
        def patient = Patient.get(params.id)
        if (!patient) {
            flash.message = message(code: 'default.not.found.message', args: ['Patient', params.id])
            return
        }

        [patient: patient]
    }

	def add() {
		[patientInstance: new Patient(params)]
    }

    def statuses() {
        render Patient.constraints.status.inList.collectEntries { [it, it] } as JSON
    }

    def jsonlist() {
        JSON.use('deep')
        render wardPatients() as JSON
    }

    private def wardPatients() {
        Patient.createCriteria().list {
            if (request.user.ward) {
                eq('ward', request.user.ward)
            }
        }
    }
}
