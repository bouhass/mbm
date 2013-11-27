package com.wardbook

import grails.converters.JSON
import groovy.sql.Sql

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
        switch (request.method) {
            case 'GET':
                [patientInstance: new Patient(params)]
                break
            case 'POST':
                def patientInstance = Patient.findByFirstNameAndLastNameAndDateOfBirth(params.firstName, params.lastName, params.dateOfBirth)
                if (patientInstance) {
                    flash.message = message(code: 'patient.add.alreadyExist', args: [patientInstance.id])
                    render view: 'add', model: [patientInstance: patientInstance]
                    return
                }

                patientInstance = new Patient(params)
                if (!patientInstance.save(flush: true)) {
                    render view: 'add', model: [patientInstance: patientInstance]
                    return
                }

                flash.message = message(code: 'default.created.message', args: ['Patient', patientInstance.id])
                redirect action: 'handover'
                break
        }
    }

    def statuses() {
        render Patient.constraints.status.inList.collectEntries { [it, it] } as JSON
    }

    def jsonlist() {
        JSON.use('deep')
        render wardPatients() as JSON
    }

    private def wardPatients() {
        def patients = Patient.createCriteria().list {
            if (request.user.ward) {
                eq('ward', request.user.ward)
            }
            if (params.referralList) {
                referralLists {
                    eq 'id', params.referralList.toLong()
                }
            }
            ne('status', 'Discharged')
        }
        return patients
    }
}
