import smartward.Patient

class BootStrap {

    def init = { servletContext ->
		new Patient(firstName: 'JOSEPH', lastName: 'LOVE').save(failOnError: true)
		new Patient(firstName: 'JOSH', lastName: 'KNIGHT').save(failOnError: true)
		new Patient(firstName: 'ANISH', lastName: 'LEE').save(failOnError: true)
    }
    def destroy = {
    }
}
