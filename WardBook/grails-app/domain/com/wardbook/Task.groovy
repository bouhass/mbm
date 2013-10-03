package com.wardbook

import org.grails.comments.Commentable

class Task /*implements Commentable*/ {

    transient springSecurityService
	
	String name
	String status = 'PENDING'
	String category = 'NURSE'
    String priority = 'NORMAL'
    Date timeDue
    String comment
	static belongsTo = [patient: Patient, creator: User, assignee: User]

    static constraints = {
		status inList: ['PENDING', 'STARTED', 'COMPLETED']
		category inList: ['NURSE', 'DOCTOR']
        priority inList: ['NORMAL', 'HIGH', 'URGENT']
        timeDue nullable: true
        comment nullable: true
        creator nullable: true, editable: false, display: false // as editable false doesn't work with selects
        assignee nullable: true
    }

    def beforeInsert() {
        def currentUser = springSecurityService.currentUser
        creator = currentUser
        assignee = currentUser
    }

	String toString() { "${name}" }
}
