package smartward

class PatientController {
	
	static scaffold = true

    def index() {
		redirect(action:list)
	}
}
