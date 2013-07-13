package com.smartward

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
}
