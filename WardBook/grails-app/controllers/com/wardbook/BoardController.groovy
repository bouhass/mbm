package com.wardbook

class BoardController {

    def springSecurityService

    def index() {
		redirect(action:handover)
	}
	
	def joblist = {
        [patients: wardPatients()]
	}
	
	def handover = {
		[patients: wardPatients()]
	}

    private def wardPatients() {
        def currentUser = springSecurityService.currentUser
        Patient.createCriteria().list {
            if (currentUser.ward) {
                eq('ward.id', currentUser.ward.id)
            }
        }
    }
}
