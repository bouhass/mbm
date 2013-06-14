package smartward

class TaskController {

    static scaffold = true

    def index() {
		redirect(action:list)
	}
	
	
}
