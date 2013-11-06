package com.wardbook



import grails.test.mixin.*

import java.util.concurrent.TimeUnit

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(Task)
class TaskTests {

    void testToString() {
        def task = new Task(name: 'task name', category: 'task type')
        assert task.toString() == 'task name'
    }
}
