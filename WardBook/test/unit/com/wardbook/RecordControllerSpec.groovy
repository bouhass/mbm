package com.wardbook

import grails.test.mixin.TestFor
import spock.lang.Specification

@TestFor(RecordController)
class RecordControllerSpec extends Specification {

    void "test index"() {
        when:
        controller.index()

        then:
        view == '/record/index'
    }
}
