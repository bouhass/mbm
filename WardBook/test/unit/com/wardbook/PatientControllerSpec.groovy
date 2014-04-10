package com.wardbook

import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import spock.lang.Specification

@TestFor(PatientController)
@Mock(Patient)
class PatientControllerSpec extends Specification {

    def patient = new Patient(
            firstName: 'John',
            lastName: 'Smith',
            hospitalIdentifier: '12345',
            dateOfBirth: new Date() - 1,
            ward: new Ward(name: 'Paul wood', speciality: 'Cardiology')
    )

    def patients = ['John', 'Bob', 'Barry']

    def setup() {
        PatientController.metaClass.isMobile = { false }
        request.user = [patients: { patients }]
//        patient.save(flush: true, failOnError: true)
    }

    void "test index"() {
        when:
        controller.index()

        then:
        response.redirectedUrl == '/patient/listview'
    }

    void "test list view"() {
        when:
        controller.listview()

        then:
        view == '/patient/listview'
        model.patients == patients

        when:
        PatientController.metaClass.isMobile = { true }
        controller.listview()

        then:
        view == '/patient/m/listview'
        model.patients == patients
    }

    void "test grid view"() {
        when:
        controller.gridview()

        then:
        view == '/patient/gridview'
        model.patients == patients
    }

    void "test job list"() {
        when:
        controller.joblist()

        then:
        view == '/patient/joblist'
        model.patients == patients
    }

//    void "test patient profile"() {
//        setup:
//        params.id = patient.id
//        when:
//        params.id = patient.id
//        controller.profile()
//
//        then:
//        view == '/patient/profile'
//        model.patient == patient
//
//        when:
//        PatientController.metaClass.isMobile = { true }
//        controller.profile()
//
//        then:
//        view == '/patient/m/profile'
//        model.patient == patient
//    }

    void "test patient profile not found"() {
        when:
        params.id = -1
        controller.profile()

        then:
        flash.message == 'default.not.found.message' // not sure thats the way to test this
    }

    void "test add"() {
        when:
        params.firstName = 'Tom'
        params.lastName = 'Jerry'
        request.method = 'GET'
        controller.add()

        then:
        view == '/patient/add'
        model.patientInstance == new Patient(firstName: 'Tom', lastName: 'Jerry')
    }

    void "test statuses"() {
        when:
        controller.statuses()

        then:
        response.json == [
                'To come in': 'To come in',
                'New Admission': 'New Admission',
                'No concerns': 'No concerns',
                'Unwell': 'Unwell',
                'Potential discharge': 'Potential discharge',
                'For Home': 'For Home',
                'Discharged': 'Discharged'
        ]
    }
}
