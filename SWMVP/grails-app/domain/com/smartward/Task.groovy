package com.smartward

class Task {
	
	String name
	String status = 'PENDING'
	String category = 'NURSE'
    String priority = 'NORMAL'
    String comment
	static belongsTo = [patient: Patient]

    static constraints = {
		status inList: ['PENDING', 'STARTED', 'COMPLETED']
		category inList: ['NURSE', 'DOCTOR']
        priority inList: ['NORMAL', 'HIGH', 'URGENT']
        comment nullable: true
    }
	
	String toString() { "${name}" }
}
