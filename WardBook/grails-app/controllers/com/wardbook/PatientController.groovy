package com.wardbook

import grails.converters.JSON

class PatientController {

    static scaffold = true

    def exportService
    def grailsApplication

    def index() {
        redirect action: listview
    }

    def listview = {
        def view = isMobile() ? 'm/listview' : 'listview'
        render view: view, model: [patients: request.user.patients()]
    }

    def gridview = {
        render view: 'gridview', model: [patients: request.user.patients()]
    }

    def joblist = {
        render view: 'joblist', model: [patients: request.user.patients()]
    }

    def profile = {
        def patient = Patient.get(params.id)
        if (!patient) {
            flash.message = message(code: 'default.not.found.message', args: ['Patient', params.id])
            return
        }

        def view = isMobile() ? 'm/profile' : 'profile'
        render view: view, model: [patient: patient]
    }

	def add() {
        switch (request.method) {
            case 'GET':
                render view: 'add', model: [patientInstance: new Patient(params)]
                break
            case 'POST':
                def patientInstance = Patient.findByFirstNameAndLastNameAndDateOfBirth(params.firstName, params.lastName, params.dateOfBirth)
                if (patientInstance) {
                    flash.message = message(code: 'patient.add.alreadyExist', args: [patientInstance.id])
                    render view: 'add', model: [patientInstance: patientInstance]
                    return
                }

                patientInstance = new Patient(params)
                patientInstance.teamLists.each { patientInstance.addToTeamLists(it) }
                if (!patientInstance.save(flush: true)) {
                    render view: 'add', model: [patientInstance: patientInstance]
                    return
                }

                // the 2 instructions below are so that the user can see his newly added patient in the list
                if (patientInstance.ward != request.user.ward)
                    request.user.ward = null

                if (patientInstance.teamLists && !patientInstance.teamLists.contains(request.user.teamList))
                    request.user.teamList = null

                flash.message = message(code: 'default.created.message', args: ['Patient', patientInstance.id])
                redirect action: 'listview', fragment: patientInstance.id, params: [new: patientInstance.id]
                break
        }
    }

    def statuses() {
        render Patient.constraints.status.inList.collectEntries { [it, it] } as JSON
    }

    def csvlist() {
        response.contentType = grailsApplication.config.grails.mime.types['csv']
        def fileName = "patients-${new Date().format('ddMMyyyyHHmm')}.csv"
        response.setHeader("Content-disposition", "attachment; filename=${fileName}")

        List fields = ['DEMOGRAPHICS', 'CLINICAL HISTORY', 'CURRENT PLAN', 'TASKS']
        Map formatters = [
                'DEMOGRAPHICS': { patient, value ->
                    return "${patient.location}\n" +
                            "${patient}\n"+
                            "${patient.consultant ?: ''}\n" +
                            "${patient.dateOfBirth.format('dd-MM-yyyy')}\n" +
                            "${patient.hospitalIdentifier}\n" +
                            "${patient.status}"
                },
                'CLINICAL HISTORY': { patient, value ->
                    return "${patient.history ?: ''}"
                },
                'CURRENT PLAN': { patient, value ->
                    return patient.records.findAll{ it.type == 'PLAN' }*.name.join('\n')
                },
                'TASKS': { patient, value ->
                    return patient.tasks*.name.join('\n')
                }
        ]
//        Map parameters = [title: "Patient list", "column.widths": [25, 25, 25, 25]]
        Map parameters = [title: "Patient list"]

        exportService.export('csv', response.outputStream, request.user.patients(), fields, [:], formatters, parameters)
    }

    def search() {
        def patients = Patient.createCriteria().list {
            if (params.q) {
                def tokens = params.q.split(' ')
                or {
                    for (token in tokens) {
                        like('firstName', "${token}%")
                        like('lastName', "${token}%")
                    }
                }
            }
            maxResults(5)
        }
        render patients as JSON
    }
}
