package com.wardbook

import grails.test.mixin.TestFor
import spock.lang.Specification

@TestFor(DashboardController)
class DashboardControllerSpec extends Specification {

    void "test index"() {
        when:
        controller.index()

        then:
        view == '/dashboard/index'
    }
}
