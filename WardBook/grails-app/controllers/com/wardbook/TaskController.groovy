package com.wardbook

class TaskController {

    static scaffold = true
	
    def index() {
		redirect action: 'listview'
	}

    def listview() {
        def patients = request.user.patients()
        def tasks = patients*.tasks.flatten().findAll { it.isActive() }
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

        def view = 'partialEdit'
        if (isMobile()) {
            view = 'm/partialEdit'
        }
        render(view: view, model: [task: task])
    }

    def add() {
        def view = 'm/add'
        switch (request.method) {
            case 'GET':
                render(view: view, model: [task: new Task(params)])
                break
            case 'POST':
                def task = new Task(params)
                if (!task.save(flush: true)) {
                    render view: view, model: [task: task]
                    return
                }

                flash.message = message(code: 'default.created.message', args: ['Task', task.id])
                redirect controller: 'patient', action: 'profile', id: task.patient.id
                break
        }
    }
}
