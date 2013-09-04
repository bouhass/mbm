package com.wardbook

import grails.converters.JSON

class TaskController {

    static scaffold = true
	
    def index() {
		redirect(action:list)
	}
	
	def saveOrUpdate() {
		def taskInstance = Task.get(params.id)
		if (taskInstance)
			taskInstance.properties = params
		else
			taskInstance = new Task(params)
			
		if (!taskInstance.save(flush: true)) {
			render view: 'create', model: [taskInstance: taskInstance]
			return
		}
		
		render taskInstance as JSON
	}

    def updateStatus() {
        def taskInstance = Task.get(params.id)
        if (!taskInstance) {
            flash.message = message(code: 'default.not.found.message', args: ['Task', params.id])
            return
        }

        taskInstance.status = params.status
        if (!taskInstance.save(flush: true)) {
//            render view: 'create', model: [taskInstance: taskInstance]
            return
        }

        render taskInstance as JSON
    }
}
