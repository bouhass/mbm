package com.wardbook

import grails.test.mixin.TestMixin
import grails.test.mixin.support.GrailsUnitTestMixin
import spock.lang.Unroll

/**
 * See the API for {@link grails.test.mixin.support.GrailsUnitTestMixin} for usage instructions
 */
@TestMixin(GrailsUnitTestMixin)
class PatientSpec extends ConstraintUnitSpec {

    static def location = 'B1B1'

    def setup() {
        mockForConstraintsTests(Patient, [new Patient(location: location)])
    }

    void "test toString should return the patient first name and surname"() {
        when:
        def patient = new Patient(firstName: 'John', lastName: 'Smith', nhsNumber: '12345')

        then:
        patient.toString() == 'John Smith'
    }

    @Unroll("#field with value #val gives #error")
    def "test all constraints"() {
        when:
        def obj = new Patient("$field": val)

        then:
        validateConstraints(obj, field, error)

        where:
        field                | val                   | error

        'firstName'          | null                  | 'nullable'
        'firstName'          | randomString(35)      | 'valid'
        'firstName'          | randomString(36)      | 'maxSize'

        'lastName'           | null                  | 'nullable'
        'lastName'           | randomString(35)      | 'valid'
        'lastName'           | randomString(36)      | 'maxSize'

        'dateOfBirth'        | new Date() + 1        | 'max'
        'dateOfBirth'        | null                  | 'nullable'
        'dateOfBirth'        | new Date() - 1        | 'valid'
        'dateOfBirth'        | new Date()            | 'valid'

        'hospitalIdentifier' | null                  | 'nullable'

        'status'             | 'Unknown'             | 'inList'
        'status'             | ''                    | 'nullable'
        'status'             | null                  | 'nullable'
        'status'             | 'To come in'          | 'valid'
        'status'             | 'New Admission'       | 'valid'
        'status'             | 'No concerns'         | 'valid'
        'status'             | 'Unwell'              | 'valid'
        'status'             | 'Potential discharge' | 'valid'
        'status'             | 'For Home'            | 'valid'
        'status'             | 'Discharged'          | 'valid'

        'consultant'         | null                  | 'valid'

        'gender'             | 'Unknown'             | 'inList'
        'gender'             | ''                    | 'valid'
        'gender'             | null                  | 'valid'
        'gender'             | 'MALE'                | 'valid'
        'gender'             | 'FEMALE'              | 'valid'

        'history'            | null                  | 'valid'
        'history'            | randomString(4096)    | 'valid'
        'history'            | randomString(4097)    | 'maxSize'

        'location'           | ''                    | 'valid'
        'location'           | null                  | 'valid'
        'location'           | location              | 'unique'
        'location'           | 'B1B2'                | 'valid'

        'nhsNumber'          | ''                    | 'valid'
        'nhsNumber'          | null                  | 'valid'

        'speciality'         | ''                    | 'valid'
        'speciality'         | null                  | 'valid'
    }
}
