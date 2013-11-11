package com.wardbook

import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import org.junit.Before

/**
* See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
*/
@TestFor(StaffController)
@Mock(User)
class StaffControllerTests {

    def users = [
            new User(name: 'michelle', username: 'teo@mbm.com', password: 'password'),
            new User(name: 'jak', username: 'marco@mbm.com', password: 'password'),
            new User(name: 'yaz', username: 'bouhass@mbm.com', password: 'password')
    ]

    @Before
    void setUp() {
        User.metaClass.encodePassword = { null }
        users*.save()
    }

    void testIndex() {
        controller.index()
        assert response.redirectedUrl == '/staff/list'
    }

//    void testList() {
//        def model = controller.list()
//
//        assert model.users == users
//    }

}
