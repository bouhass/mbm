package com.wardbook

import grails.test.mixin.TestMixin
import grails.test.mixin.support.GrailsUnitTestMixin
import spock.lang.Unroll

/**
 * See the API for {@link grails.test.mixin.support.GrailsUnitTestMixin} for usage instructions
 */
@TestMixin(GrailsUnitTestMixin)
class TeamListSpec extends ConstraintUnitSpec {

    def setup() {
        mockForConstraintsTests(TeamList)
    }

    void "test toString should return the team list name"() {
        when:
        def teamList = new TeamList(name: 'list name')

        then:
        teamList.toString() == 'list name'
    }

    @Unroll("#field with value #val gives #error")
    def "test all constraints"() {
        when:
        def obj = new TeamList("$field": val)

        then:
        validateConstraints(obj, field, error)

        where:
        field        | val          | error

        'name'       | null         | 'nullable'
        'name'       | ''           | 'nullable'
        'name'       | 'Alpha team' | 'valid'

        'patients'   | null         | 'valid'

        'users'      | null         | 'valid'
    }
}
