package com.wardbook

import groovy.transform.EqualsAndHashCode
import org.grails.comments.Commentable

@EqualsAndHashCode
@gorm.AuditStamp
class Patient implements Commentable {
	
	String  firstName
	String  lastName
	Date    dateOfBirth
    String  hospitalIdentifier
    String  status = 'No concerns'
    Boolean handover = false
    Ward    ward

    // optional
    User    consultant
	String  gender
    String  history
	String  location
	String  nhsNumber
	String  speciality

	static hasMany = [tasks: Task, records: Record, teamLists: TeamList]
    static belongsTo = [Ward, User, TeamList]

    static constraints = {
		firstName nullable:false, maxSize: 35
		lastName nullable:false, maxSize: 35
        dateOfBirth max:new Date()
        hospitalIdentifier nullable:false
		status inList: [
                'To come in',
                'New Admission',
                'No concerns',
                'Unwell',
                'Potential discharge',
                'For Home',
                'Discharged'
        ]

        consultant nullable:true
        gender nullable:true, inList: ['MALE', 'FEMALE']
        history nullable:true, maxSize: 4096
		location nullable:true
		nhsNumber nullable:true
        speciality nullable:true
    }

	String toString() { "${firstName} ${lastName}" }
}
