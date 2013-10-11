package com.wardbook

import org.grails.comments.Commentable

@gorm.AuditStamp
class Task implements Commentable {

    transient springSecurityService
	
	String name
	String status = 'PENDING'
	String category = 'NURSE'
    String priority = 'NORMAL'
    Date timeDue
	static belongsTo = [patient: Patient, assignee: User]

    static constraints = {
		status inList: ['PENDING', 'STARTED', 'COMPLETED']
		category inList: ['NURSE', 'DOCTOR']
        priority inList: ['NORMAL', 'URGENT']
        timeDue nullable: true
        assignee nullable: true
    }

    def beforeInsert() {
        assignee = springSecurityService.currentUser
    }

	String toString() { "${name}" }
}
