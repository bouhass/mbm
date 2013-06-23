package com.smartward

class Patient {
	
	String firstName
	String lastName
	Date dateOfBirth
	String status

    static constraints = {
		dateOfBirth nullable:true
		status nullable:true
    }
}
