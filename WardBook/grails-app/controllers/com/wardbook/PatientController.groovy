package com.wardbook

import grails.converters.JSON

class PatientController {

    static scaffold = true

    def index() {
		redirect action: 'overview', params: params
	}
	
	def overview() {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		[patientInstanceList: Patient.list(params), patientInstanceTotal: Patient.count()]
	}
	
	def summary() {
		def patientInstance = Patient.get(params.id)
		if (!patientInstance) {
			flash.message = message(code: 'default.not.found.message', args: ['Patient', params.id])
			return
		}

		[patientInstance: patientInstance]
	}
	
	def add() {
		[patientInstance: new Patient(params)]
	}

    def partialUpdate() {
        def patientInstance = Patient.get(params.id)
        if (!patientInstance) {
            flash.message = message(code: 'default.not.found.message', args: ['Patient', params.id])
            return
        }

        patientInstance.properties = params
        if (!patientInstance.save(flush: true)) {
//            render view: 'create', model: [patientInstance: patientInstance]
            return
        }

        render patientInstance as JSON
    }

    def statuses() {
        render Patient.constraints.status.inList.collectEntries { [it, it] } as JSON
    }

    def jsonlist() {
        JSON.use('deep')
        render Patient.list() as JSON
    }
}
