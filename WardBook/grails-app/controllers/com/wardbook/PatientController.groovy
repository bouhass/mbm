package com.wardbook

import grails.converters.JSON

class PatientController {

    static scaffold = true

    def exportService
    def grailsApplication

    def index() {
        redirect(action:listview)
    }

    def listview = {
        def view = 'listview'
        if (isMobile()) {
            view = 'm/listview'
        }
        render(view: view, model: [patients: request.user.patients()])
    }

    def gridview = {
        render(view: 'gridview', model: [patients: request.user.patients()])
    }

    def joblist = {
        [patients: request.user.patients()]
    }

    def profile() {
        def patient = Patient.get(params.id)
        if (!patient) {
            flash.message = message(code: 'default.not.found.message', args: ['Patient', params.id])
            return
        }

        def view = 'profile'
        if (isMobile()) {
            view = 'm/profile'
        }
        render(view: view, model: [patient: patient])
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
                redirect action: 'listview'
                break
        }
    }

    def statuses() {
        render Patient.constraints.status.inList.collectEntries { [it, it] } as JSON
    }

    def jsonlist() {
        JSON.use('deep')
        render request.user.patients() as JSON
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
                    def plans = ""
                    patient.records.each {
                        if (it.type == 'PLAN') {
                            plans += it.name+'\n'
                        }
                    }
                    return plans
                },
                'TASKS': { patient, value ->
                    def tasks = ""
                    patient.tasks.each {
                        tasks += it.name+'\n'
                    }
                    return tasks
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
