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
    }

    void testIndex() {
        controller.index()
        assert response.redirectedUrl == '/patient/overview'
    }

    void testOverview() {
        def model = controller.overview()

        assert model.patientInstanceList == patient_list
        assert model.patientInstanceTotal == patient_list.size
    }

    void testSummary() {
        params.id = joseph_love.id

        def model = controller.summary()

        assert model.patientInstance == joseph_love
    }

    void testSummaryPatientNotFound() {
        params.id = -1

        def model = controller.summary()

        assert flash.message == 'default.not.found.message' // not sure thats the way to test this
    }

    void testAdd() {
        params.firstName = 'John'
        params.lastName = 'Smith'

        def model = controller.add()

        assert model.patientInstance == new Patient(firstName: 'John', lastName: 'Smith')
    }

    void testPartialUpdate() {
        params.id = josh_knight.id
        params.status = 'For Home'

        assert josh_knight.status == 'Default (no concerns)'

        controller.partialUpdate()

        assert josh_knight.status == 'For Home'
        assert response.text == new JSON(josh_knight).toString()
    }

    void testStatuses() {
        controller.statuses()

        assert response.json == [
                'Default (no concerns)': 'Default (no concerns)',
                'New Admission': 'New Admission',
                'Unwell': 'Unwell',
                'For Home': 'For Home'
        ]
    }

    void testJsonlist() {
        controller.jsonlist()

        assert response.text == new JSON(patient_list).toString()
    }

}
