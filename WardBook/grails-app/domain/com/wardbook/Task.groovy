package com.wardbook

import org.grails.comments.Commentable

import java.util.concurrent.TimeUnit

@gorm.AuditStamp
class Task implements Commentable {

    static auditable = [ignore:['editedBy', 'editedDate']]

    static transients = ['active']

    transient springSecurityService

	String name
	String status = 'PENDING'
    String priority = 'NON-URGENT'
    Date timeDue
	static belongsTo = [patient: Patient, assignee: User]

    static constraints = {
		status inList: ['PENDING', 'STARTED', 'COMPLETED']
        priority inList: ['NON-URGENT', 'URGENT']
        timeDue nullable: true
        assignee nullable: true
    }

    def beforeInsert() {
        if (this.assignee == null) {
            assignee = springSecurityService.currentUser
        }
    }

	String toString() { "${name}" }

    boolean isActive() {
        (status != 'COMPLETED') || (createdDate > new Date(System.currentTimeMillis() - TimeUnit.DAYS.toMillis(1)))
    }
}
