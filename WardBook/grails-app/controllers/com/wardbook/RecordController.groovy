package com.wardbook

import grails.converters.JSON

class RecordController {
	
	static scaffold = true

    def index() { }

    def saveOrUpdate() {
        def recordInstance = Record.get(params.id)
        if (recordInstance)
            recordInstance.properties = params
        else
            recordInstance = new Record(params)

        if (!recordInstance.save(flush: true)) {
            render view: 'create', model: [recordInstance: recordInstance]
            return
        }

        render recordInstance as JSON
    }
}
