package com.wardbook

import grails.converters.JSON
import groovy.sql.Sql

class PatientController {

    static scaffold = true

    def index() {
        redirect(action:handover)
    }

    def handover = {
        [patients: wardPatients(), referralLists: referralListNames()]
    }

    def joblist = {
        [patients: wardPatients(), referralLists: referralListNames()]
    }

    def profile() {
        def patient = Patient.get(params.id)
        if (!patient) {
            flash.message = message(code: 'default.not.found.message', args: ['Patient', params.id])
            return
        }

        [patient: patient, referralLists: referralListNames()]
    }

	def add() {
        switch (request.method) {
            case 'GET':
                [patientInstance: new Patient(params), referralLists: referralListNames()]
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
            ne('status', 'Discharged')
        }
        /* At the moment there is no way of using criterias with a list of primitives (String, Enum).
        Alternatives are: 1) HQL, 2) Wrapper class for the primitive type, 3) the following: */
        if (params.referralList) {
            patients = patients.findAll { it.referralLists.contains(params.referralList) }
        }
        return patients
    }

    private def referralListNames() {
        def sql = new Sql(applicationContext.dataSource)
        def results = sql.rows("select distinct referral_lists_string from patient_referral_lists")
        return results.collect { it['referral_lists_string'] }
    }
}
