package com.wardbook

import org.grails.comments.Commentable

import java.util.concurrent.TimeUnit

@gorm.AuditStamp
class Task implements Commentable {

    transient springSecurityService

    static transients = ['active']
	
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

    boolean isActive() {
        (status != 'COMPLETED') || (createdDate > new Date(System.currentTimeMillis() - TimeUnit.DAYS.toMillis(1)))
    }
}
