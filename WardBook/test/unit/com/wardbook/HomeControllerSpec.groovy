package com.wardbook

import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(HomeController)
class HomeControllerSpec extends Specification {

    def setup() {
        controller.metaClass.isMobile = { return false }
        request.user = []
    }


    void "if user has a ward selected should redirect to patient list"() {
        setup:
        request.user = [ward: 'a ward']

        when:
        controller.index()

        then:
        response.redirectUrl == '/patients'
    }


    void "if user has a list selected should redirect to patient list"() {
        setup:
        request.user = [referralList: 'a list']

        when:
        controller.index()

        then:
        response.redirectUrl == '/patient'
    }


    void "if user not selected a ward nor a list should redirect to selection screen"() {
        when:
        controller.index()

        then:
        view == '/home/index'
    }


    void "if mobile, should redirect to patient list"() {
        setup:
        controller.metaClass.isMobile = { return true }

        when:
        controller.index()

        then:
        response.redirectUrl == '/patient'
    }
}
