package com.wardbook



import grails.test.mixin.*

/**
* See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
*/
@TestFor(Patient)
class PatientTests {

    void testToString() {
        def patient = new Patient(firstName: 'John', lastName: 'Smith', nhsNumber: '12345')
        assert patient.toString() == 'John Smith'
    }
}
