package com.wardbook

import grails.test.mixin.*
import org.junit.Before

import java.util.concurrent.TimeUnit

/**
* See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
*/
@TestFor(Task)
class TaskTests {

    def task = new Task(name: 'task name')
    def two_days_ago = new Date(System.currentTimeMillis() - TimeUnit.DAYS.toMillis(2))

    @Before
    void setUp() {
        Task.metaClass.getCreatedDate = { new Date() }
    }

    void testToString() {
        assert task.toString() == 'task name'
    }

//    void testIsActive() {
//        assert task.isActive()
//
//        task.status = 'COMPLETED'
//        assert task.isActive()
//
//        Task.metaClass.getCreatedDate = { two_days_ago }
//        task.status = 'PENDING'
//        assert task.isActive()
//    }

    void testInNotActive() {
        Task.metaClass.getCreatedDate = { two_days_ago }
        task.status = 'COMPLETED'
        assert !task.isActive()
    }

    void testBeforeInsert() {
        def user = new User(name: 'jak', username: 'marco@toto.com', password: 'password')
        task.springSecurityService = [currentUser: user]

        assert task.assignee == null
        task.beforeInsert()
        assert task.assignee == user
    }
}
