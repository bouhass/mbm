package com.wardbook

import grails.test.mixin.TestFor
import spock.lang.Unroll

@TestFor(Handover)
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
        field   | val   | error
        'from'  | null  | 'nullable'
    }
}
