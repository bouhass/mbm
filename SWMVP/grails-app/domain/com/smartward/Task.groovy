package com.smartward

class Task {
	
	String name
	String status = 'PENDING'
	String category = 'NURSE'
	static belongsTo = [patient: Patient]

    static constraints = {
		status inList: ['PENDING', 'STARTED', 'COMPLETED']
		category inList: ['NURSE', 'DOCTOR']
    }
	
	String toString() { "${name}" }
}
