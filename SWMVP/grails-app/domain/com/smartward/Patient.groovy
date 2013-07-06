package com.smartward

class Patient {
	
	String firstName
	String lastName
	Date dateOfBirth
	String gender
	String nhsNumber
	String status = 'Default (no concerns)'
	String location
	String consultant
	String speciality
	static hasMany = [tasks: Task, records: Record]

    static constraints = {
		firstName nullable:false
		lastName nullable:false
		gender inList: ['MALE', 'FEMALE']
		status inList: ['For Home', 'Unwell', 'New Admission', 'Default (no concerns)']
		location nullable:true
		nhsNumber nullable:true
    }
	
	String toString() { "${firstName} ${lastName}" }
}
