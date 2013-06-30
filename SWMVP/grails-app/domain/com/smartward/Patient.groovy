package com.smartward

class Patient {
	
	String firstName
	String lastName
	Date dateOfBirth
	String nhsNumber
	String status = 'ADMITTED'
	String location
	static hasMany = [tasks: Task, records: Record]

    static constraints = {
		firstName nullable:false
		lastName nullable:false
		status inList: ['ADMITTED', 'FOR HOME', 'LEFT']
		location nullable:true
		nhsNumber nullable:true
    }
	
	String toString() { "${firstName} ${lastName}" }
}
