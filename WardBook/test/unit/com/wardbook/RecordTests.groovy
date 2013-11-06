package com.wardbook



import grails.test.mixin.*

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(Record)
class RecordTests {

    void testToString() {
        def record = new Record(name: 'record name', type: 'record type')
        assert record.toString() == 'record name'
    }
}
