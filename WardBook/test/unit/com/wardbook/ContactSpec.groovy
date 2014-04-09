package com.wardbook

import grails.test.mixin.TestMixin
import grails.test.mixin.support.GrailsUnitTestMixin
import spock.lang.Unroll

@TestMixin(GrailsUnitTestMixin)
class ContactSpec extends ConstraintUnitSpec {

    def setup() {
        mockForConstraintsTests(Contact)
    }

    @Unroll("#field with value #val gives #error")
    def "test all constraints"() {
        when:
        def obj = new Contact("$field": val)

        then:
        validateConstraints(obj, field, error)

        where:
        field         | val     |  error
        'name'        | null    |  'nullable'
        'phoneNumber' | null    |  'nullable'
    }
}
