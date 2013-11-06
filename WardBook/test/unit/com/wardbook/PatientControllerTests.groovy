package com.wardbook

import grails.converters.JSON
import grails.test.mixin.*
import grails.test.mixin.domain.DomainClassUnitTestMixin

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(PatientController)
@Mock(Patient)
@TestMixin(DomainClassUnitTestMixin)
//@Mixin(Personas)
class PatientControllerTests {

    void setUp() {
        PatientControllerTests.mixin Personas
        mockDomain(Patient, patient_list)
        mockDomain(Ward, ward_list)
    }

    void testIndex() {
        controller.index()
        assert response.redirectedUrl == '/patient/handover'
    }

//    void testPatientList() {
//        def model = controller.handover()
//
//        assert model.patients == patient_list
//    }
//
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

        def model = controller.add()

        assert model.patientInstance == new Patient(firstName: 'John', lastName: 'Smith')
    }

    void testStatuses() {
        controller.statuses()

        assert response.json == [
                'Default (no concerns)': 'Default (no concerns)',
                'New Admission': 'New Admission',
                'Unwell (To Be Aware)': 'Unwell (To Be Aware)',
                'Unwell (For Night Review)': 'Unwell (For Night Review)',
                'Unwell (Urgent Review)': 'Unwell (Urgent Review)',
                'For Home': 'For Home'
        ]
    }

//    void testJsonlist() {
//        controller.jsonlist()
//
//        assert response.text == new JSON(patient_list).toString()
//    }

}
