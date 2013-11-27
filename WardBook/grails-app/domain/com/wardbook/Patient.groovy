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
	String speciality
    Boolean handover = false
    Ward ward
    User consultant
	static hasMany = [tasks: Task, records: Record, referralLists: ReferralList]
    static belongsTo = [Ward, User, ReferralList]

    static constraints = {
		firstName nullable:false
		lastName nullable:false
        dateOfBirth max:new Date()
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
        consultant nullable:true
        speciality nullable:true
    }

	String toString() { "${firstName} ${lastName}" }
}
