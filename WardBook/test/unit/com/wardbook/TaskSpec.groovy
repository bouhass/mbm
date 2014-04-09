package com.wardbook

import grails.test.mixin.TestMixin
import grails.test.mixin.support.GrailsUnitTestMixin
import spock.lang.Unroll

import java.util.concurrent.TimeUnit

@TestMixin(GrailsUnitTestMixin)
class TaskSpec extends ConstraintUnitSpec {

    def task = new Task()
    def two_days_ago = new Date(System.currentTimeMillis() - TimeUnit.DAYS.toMillis(2))

    void setup() {
        Task.metaClass.getCreatedDate = { new Date() }
        mockForConstraintsTests(Task)
    }

    def "test that toString method should return the task name"() {
        when:
        task.name = 'a task name'

        then:
        task.toString() == 'a task name'
    }

//    TODO : this test is failing using the grails command line
//    void "test that a task marked as COMPLETED but created within 2 days is still active"() {
//        when:
//        Task.metaClass.getCreatedDate = { new Date() }
//        task.status = 'COMPLETED'
//
//        then:
//        task.isActive()
//    }

    void "test that a task should be active by default"() {
        when:
        task.status = 'PENDING'

        then:
        task.isActive()

    }

    void "test when a task is 2 days old but is not marked as COMPLETED it is still active"() {
        when:
        Task.metaClass.getCreatedDate = { two_days_ago }
        task.status = 'PENDING'

        then:
        task.isActive()
    }

    def "test when a task has been completed 2 days ago then it should not be active"() {
        when:
        Task.metaClass.getCreatedDate = { two_days_ago }
        task.status = 'COMPLETED'

        then:
        !task.isActive()
    }

    def "test assignee should be populated before insert"() {
        when:
        def user = new User(name: 'jak', username: 'marco@toto.com', password: 'password')
        task.springSecurityService = [currentUser: user]

        then:
        task.assignee == null

        when:
        task.beforeInsert()

        then:
        task.assignee == user
    }

    @Unroll("#field with value #val gives #error")
    def "test all constraints"() {
        when:
        def obj = new Task("$field": val)

        then:
        validateConstraints(obj, field, error)

        where:
        field       | val           | error

        'status'    | 'Unknown'     | 'inList'
        'status'    | ''            | 'nullable'
        'status'    | null          | 'nullable'
        'status'    | 'PENDING'     | 'valid'
        'status'    | 'STARTED'     | 'valid'
        'status'    | 'COMPLETED'   | 'valid'

        'priority'  | 'Unknown'     | 'inList'
        'priority'  | ''            | 'nullable'
        'priority'  | null          | 'nullable'
        'priority'  | 'NON-URGENT'  | 'valid'
        'priority'  | 'URGENT'      | 'valid'

        'timeDue'   | null          | 'valid'

        'assignee'  | null          | 'valid'
    }
}
