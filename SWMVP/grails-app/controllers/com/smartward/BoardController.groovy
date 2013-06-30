package com.smartward

class BoardController {

    def index() {
		redirect(action:ward)
	}
	
	def ward = {
		[patients: Patient.list()]
	}
	
	def handover = {
		[patients: Patient.list()]
	}
}
