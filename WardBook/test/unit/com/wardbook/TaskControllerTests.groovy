package com.wardbook



import grails.test.mixin.*
import org.junit.Before

/**
* See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
*/
@TestFor(TaskController)
@Mock([Task, User, Patient])
class TaskControllerTests {

    def user = new User(name: 'yaz', username: 'bouhass@mbm.com', password: 'password')

    def tasks = [
            new Task(name: 'Blood tests'),
            new Task(name: 'X-Ray')
    ]

    @Before
    void setUp() {
        this.class.mixin Personas

        patient_list*.save(flush: true)

        User.metaClass.encodePassword = { null }
        user.save(flush: true)

        tasks*.setAssignee(user)
        tasks*.setPatient(josh_knight)
        tasks*.springSecurityService = [currentUser: user]
        tasks*.save(flush: true)

        request.setAttribute('user', user)
    }

    void testIndex() {
        controller.index()

        assert response.redirectedUrl == '/task/mylist'
    }

//    void testMylist() {
//        def model = controller.mylist()
//
//        assert model.tasks == tasks
//    }

//    void testSummary() {
//        params.id = tasks[0].id
//
//        def model = controller.summary()
//
//        assert model.task == tasks[0]
//    }

//    void testPartialEdit() {
//        params.id = tasks[1].id
//
//        def model = controller.partialEdit()
//
//        assert model.task == tasks[1]
//    }

}
