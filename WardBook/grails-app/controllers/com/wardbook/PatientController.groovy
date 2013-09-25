package com.wardbook

import grails.converters.JSON

class PatientController {

    static scaffold = true

    def index() {
		redirect action: 'mylist', params: params
	}

    def list() {
        redirect action: 'overview', params: params
    }
	
	def overview() {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		[patientInstanceList: Patient.list(params), patientInstanceTotal: Patient.count()]
	}
	
	def summary() {
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

    def mylist() {
        def patientList = Patient.createCriteria().list {
            if (params.ward) {
                eq('ward.id', "${params.ward}".toLong())
            }
            if (params.consultant) {
                eq('consultant', "${params.consultant}")
            }
            if (params.status) {
                eq('status', "${params.status}")
            }
            maxResults(Math.min(params.max ? params.int('max') : 10, 100))
        }

        [patients: patientList.groupBy { it.ward }, patientInstanceTotal: Patient.count()]
    }

    def statuses() {
        render Patient.constraints.status.inList.collectEntries { [it, it] } as JSON
    }

    def jsonlist() {
        JSON.use('deep')
        render Patient.list() as JSON
    }
}
