package com.wardbook

class TaskController {

    static scaffold = true
	
    def index() {
		redirect action: 'mylist'
	}

    def mylist() {
        def tasks = Task.createCriteria().list {
            eq('assignee.id', request.user.id)
        }
        [tasks: tasks]
    }

    def summary() {
        def task = Task.get(params.id)
        if (!task) {
            flash.message = message(code: 'default.not.found.message', args: ['Task', params.id])
            return
        }

        [task: task]
    }

    def partialEdit() {
        def task = Task.get(params.id)
        if (!task) {
            flash.message = message(code: 'default.not.found.message', args: ['Task', params.id])
            return
        }

        [task: task]
    }
}
