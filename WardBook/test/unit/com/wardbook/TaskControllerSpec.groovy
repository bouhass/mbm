package com.wardbook

import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import spock.lang.Specification

@TestFor(TaskController)
@Mock(Task)
class TaskControllerSpec extends Specification {

    def setup() {
    }

    void "test index"() {
        when:
        controller.index()

        then:
        response.redirectedUrl == '/task/listview'
    }

    void "test add task page"() {
        when:
        request.method = 'GET'
        controller.add()

        then:
        view == '/task/m/add'
        model.task != null
    }

//    void "test adding a valid task"() {
//        when:
//        request.method = 'POST'
//        params.name = 'x-ray'
//        params.'patient.id' = 1
//        controller.add()
//
//        then:
//        Task.count() == 1
//        response.redirectedUrl == "/task/index"
//        flash.message != null
//    }

    void "test adding an invalid task"() {
        when:
        request.method = 'POST'
        controller.add()

        then:
        view == '/task/m/add'
        model.task != null
    }

//    def user = new User(name: 'yaz', username: 'bouhass@mbm.com', password: 'password')
//
//    def tasks = [
//            new Task(name: 'Blood tests'),
//            new Task(name: 'X-Ray')
//    ]
//
//    @Before
//    void setUp() {
//        this.class.mixin Personas
//
//        patient_list*.save(flush: true)
//
//        User.metaClass.encodePassword = { null }
//        user.save(flush: true)
//
//        tasks*.setAssignee(user)
//        tasks*.setPatient(josh_knight)
//        tasks*.springSecurityService = [currentUser: user]
//        tasks*.save(flush: true)
//
////        request.setAttribute('user', user)
//    }

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
