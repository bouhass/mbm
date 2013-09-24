package com.wardbook

import grails.converters.JSON

class TaskController {

    static scaffold = true
	
    def index() {
		redirect(action:list)
	}

}
