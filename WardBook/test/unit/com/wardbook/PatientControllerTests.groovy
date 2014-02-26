package com.wardbook

import grails.converters.JSON
import grails.test.mixin.*
import org.junit.Before

/**
* See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
*/
@TestFor(PatientController)
@Mock([Patient, Ward])
class PatientControllerTests {

    @Before
    void setUp() {
        this.class.mixin Personas

        ward_list*.save(flush: true)
        patient_list*.save(flush: true)

//        request.setAttribute('user', [ward: null])
    }

    void testIndex() {
        controller.index()
        assert response.redirectedUrl == '/patient/listview'
    }

//    void testPatientList() {
//        def model = controller.handover()
//
//        assert model.patients == patient_list
//    }

//    void testJobList() {
//        def model = controller.joblist()
//
//        assert model.patients == patient_list
//    }

//    void testPatientProfile() {
//        params.id = joseph_love.id
//
//        def model = controller.profile()
//
//        assert model.patient == joseph_love
//    }

    void testPatientProfileNotFound() {
        params.id = -1

        controller.profile()

        assert flash.message == 'default.not.found.message' // not sure thats the way to test this
    }

    void testAdd() {
        params.firstName = 'John'
        params.lastName = 'Smith'
        request.method = 'GET'

        def model = controller.add()

        assert model.patientInstance == new Patient(firstName: 'John', lastName: 'Smith')
    }

    void testStatuses() {
        controller.statuses()

        assert response.json == [
                'To come in': 'To come in',
                'New Admission': 'New Admission',
                'No concerns': 'No concerns',
                'Unwell': 'Unwell',
                'Potential discharge': 'Potential discharge',
                'For home': 'For home',
                'Discharged': 'Discharged'
        ]
    }

//    void testJsonlist() {
//        controller.jsonlist()
//
//        assert response.text == new JSON(patient_list).toString()
//    }

}
