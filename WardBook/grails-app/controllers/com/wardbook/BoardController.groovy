package com.wardbook

class BoardController {

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
        Patient.createCriteria().list {
            if (request.user.ward) {
                eq('ward.id', request.user.ward.id)
            }
        }
    }
}
