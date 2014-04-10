package com.wardbook

import grails.test.mixin.TestFor
import spock.lang.Specification

@TestFor(WardController)
class WardControllerSpec extends Specification {

    void "test index"() {
        when:
        controller.index()

        then:
        view == '/ward/index'
    }
}
