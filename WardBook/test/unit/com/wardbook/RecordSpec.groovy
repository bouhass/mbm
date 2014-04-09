package com.wardbook

import grails.test.mixin.TestMixin
import grails.test.mixin.support.GrailsUnitTestMixin
import spock.lang.Unroll

/**
 * See the API for {@link grails.test.mixin.support.GrailsUnitTestMixin} for usage instructions
 */
@TestMixin(GrailsUnitTestMixin)
class RecordSpec extends ConstraintUnitSpec {

    def setup() {
        mockForConstraintsTests(Record)
    }

    def "test toString returns the record name"() {
        when:
        def record = new Record(name: 'record name', type: 'record type')

        then:
        record.toString() == 'record name'
    }

    @Unroll("#field with value #val gives #error")
    def "test all constraints"() {
        when:
        def obj = new Record("$field": val)

        then:
        validateConstraints(obj, field, error)

        where:
        field  | val         | error

        'type' | 'Unknown'   | 'inList'
        'type' | ''          | 'nullable'
        'type' | null        | 'nullable'
        'type' | 'ALERT'     | 'valid'
        'type' | 'DIET'      | 'valid'
        'type' | 'HISTORY'   | 'valid'
        'type' | 'MOBILITY'  | 'valid'
        'type' | 'NOTE'      | 'valid'
        'type' | 'PLAN'      | 'valid'
        'type' | 'PREMORBID' | 'valid'
        'type' | 'PROBLEM'   | 'valid'
        'type' | 'PROGRESS'  | 'valid'
        'type' | 'SOCIAL'    | 'valid'
        'type' | 'WEIGHT'    | 'valid'
    }
}
