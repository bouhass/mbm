package com.wardbook



import grails.test.mixin.*
import org.junit.*

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(ReferralList)
class ReferralListTests {

    void testToString() {
        def referralList = new ReferralList(name: 'list name')
        assert referralList.toString() == 'list name'
    }
}
