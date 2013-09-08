package com.wardbook

class BoardController {

    def index() {
		redirect(action:joblist)
	}
	
	def joblist = {
		[patients: Patient.list()]
	}
	
	def handover = {
		[patients: Patient.list()]
	}
}
