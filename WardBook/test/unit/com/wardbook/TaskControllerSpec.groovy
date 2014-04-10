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
}
