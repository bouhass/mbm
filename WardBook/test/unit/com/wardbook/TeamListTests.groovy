package com.wardbook



import grails.test.mixin.*

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(TeamList)
class TeamListTests {

    void testToString() {
        def teamList = new TeamList(name: 'list name')
        assert teamList.toString() == 'list name'
    }
}
