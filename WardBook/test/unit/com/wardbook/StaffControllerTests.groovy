package com.wardbook

import grails.test.mixin.TestFor

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(StaffController)
class StaffControllerTests {

    void testIndex() {
        controller.index()
        assert response.redirectedUrl == '/staff/list'
    }

//    void testList() {
//        def model = controller.list()
//
//        assert model.users == User.list()
//    }

}
