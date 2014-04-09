package com.wardbook

import grails.test.mixin.TestMixin
import grails.test.mixin.support.GrailsUnitTestMixin
import spock.lang.Unroll

/**
 * See the API for {@link grails.test.mixin.support.GrailsUnitTestMixin} for usage instructions
 */
@TestMixin(GrailsUnitTestMixin)
class WardSpec extends ConstraintUnitSpec {

    def setup() {
        mockForConstraintsTests(Ward)
    }

    void "test toString should return the ward name and speciality"() {
        when:
        def ward = new Ward(name: 'paul wood', speciality: 'cardiology')

        then:
        ward.toString() == 'paul wood - cardiology'
    }

    @Unroll("#field with value #val gives #error")
    def "test all constraints"() {
        when:
        def obj = new Ward("$field": val)

        then:
        validateConstraints(obj, field, error)

        where:
        field        | val          | error

        'name'       | null         | 'nullable'
        'name'       | ''           | 'nullable'
        'name'       | 'Paul wood'  | 'valid'

        'speciality' | null         | 'nullable'
        'speciality' | ''           | 'nullable'
        'speciality' | 'Cardiology' | 'valid'

        'patients'   | null         | 'valid'

        'users'      | null         | 'valid'
    }
}
