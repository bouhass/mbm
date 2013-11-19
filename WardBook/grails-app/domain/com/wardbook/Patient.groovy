package com.wardbook

import groovy.transform.EqualsAndHashCode
import org.grails.comments.Commentable

@EqualsAndHashCode
@gorm.AuditStamp
class Patient implements Commentable {
	
	String firstName
	String lastName
	Date dateOfBirth
	String gender
	String nhsNumber
	String status = 'Default (no concerns)'
	String location
	String consultant
	String speciality
    Boolean handover = false
	static hasMany = [tasks: Task, records: Record]
    static belongsTo = [ward: Ward]

    static constraints = {
		firstName nullable:false
		lastName nullable:false
		gender inList: ['MALE', 'FEMALE']
		status inList: [
                'Default (no concerns)',
                'New Admission',
                'Unwell (To Be Aware)',
                'Unwell (For Night Review)',
                'Unwell (Urgent Review)',
                'For Home',
                'Discharged'
        ]
		location nullable:true
		nhsNumber nullable:true
    }

	String toString() { "${firstName} ${lastName}" }
}
