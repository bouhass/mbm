package com.wardbook

import groovy.transform.EqualsAndHashCode

@EqualsAndHashCode
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
    static belongsTo = [ward: Ward]

    static constraints = {
		firstName nullable:false
		lastName nullable:false
		gender inList: ['MALE', 'FEMALE']
		status inList: ['Default (no concerns)', 'New Admission', 'Unwell', 'For Home']
		location nullable:true
		nhsNumber nullable:true
    }
	
	String toString() { "${firstName} ${lastName}" }
}
