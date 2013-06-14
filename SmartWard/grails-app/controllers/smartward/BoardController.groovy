package smartward

class BoardController {

    def index() {
		redirect(action:ward)
	}
	
	def ward = {
		[patients: Patient.list()]
	}
}
