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

    def partialUpdate() {
        def taskInstance = Task.get(params.id)
        if (!taskInstance) {
            flash.message = message(code: 'default.not.found.message', args: ['Task', params.id])
            return
        }

        taskInstance.properties = params
        if (!taskInstance.save(flush: true)) {
//            render view: 'create', model: [taskInstance: taskInstance]
            return
        }

        render taskInstance as JSON
    }

    def names() {
        def results = Task.createCriteria().list {
            projections {
                distinct('name')
            }
            if (params.q) {
                like('name', "${params.q}%")
                maxResults(5)
            }
        }
        render results as JSON
    }
}
