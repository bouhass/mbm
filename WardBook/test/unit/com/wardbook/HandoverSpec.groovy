package com.wardbook

import grails.test.mixin.TestMixin
import grails.test.mixin.support.GrailsUnitTestMixin
import spock.lang.Unroll

@TestMixin(GrailsUnitTestMixin)
class HandoverSpec extends ConstraintUnitSpec {

    def setup() {
        mockForConstraintsTests(Handover)
    }

    @Unroll("#field with value #val gives #error")
    def "test all constraints"() {
        when:
        def obj = new Handover("$field": val)

        then:
        validateConstraints(obj, field, error)

        where:
        field  | val  | error
        'from' | null | 'nullable'
        'from' | ''   | 'nullable'
        'to'   | null | 'valid'
        'to'   | ''   | 'valid'
    }
}
