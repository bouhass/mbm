package com.wardbook

import java.util.concurrent.TimeUnit

@gorm.AuditStamp
class User {

    transient springSecurityService

    static transients = ['online', 'status']

    String username
    String password
    boolean enabled = true
    boolean accountExpired = false
    boolean accountLocked = false
    boolean passwordExpired = false

    // added fields
    String name
    String phoneNumber
    Date lastSeenAt
    String grade
    Boolean onCall
    String speciality
    static hasMany = [createdTasks: Task, assignedTasks: Task, patients: Patient, givenHandovers: Handover, receivedHandovers: Handover]
    static mappedBy = [assignedTasks: 'assignee', givenHandovers: 'from', receivedHandovers: 'to']
    static belongsTo = [ward: Ward, referralList: ReferralList]

    static constraints = {
        username blank: false, unique: true
        password blank: false
        phoneNumber nullable: true
        lastSeenAt nullable: true
        grade nullable: true
        onCall nullable: true
        speciality nullable: true
        ward nullable: true
        referralList nullable: true
    }

    static mapping = {
        password column: '`password`'
    }

    Set<Role> getAuthorities() {
        UserRole.findAllByUser(this).collect { it.role } as Set
    }

    def beforeInsert() {
        encodePassword()
    }

    def beforeUpdate() {
        if (isDirty('password')) {
            encodePassword()
        }
    }

    def onLoad() {
        if (springSecurityService.currentUser == this) {
            User.async.withTransaction {
                lastSeenAt = new Date()
            }
        }
    }

    protected void encodePassword() {
        password = springSecurityService.encodePassword(password)
    }

    String toString() { "${name}" }

    boolean isOnline() {
        return lastSeenAt && lastSeenAt.after(new Date(System.currentTimeMillis() - TimeUnit.MINUTES.toMillis(1)))
    }

    String getStatus() {
        if (isOnline()) {
            if (onCall) {
                 'on-call'
            }
            else {
                'online'
            }
        }
        else {
            'offline'
        }
    }

    static def consultants() {
        def role = Role.findByAuthority('ROLE_CONSULTANT')
        def userRoles = UserRole.findAllByRole(role)
        userRoles*.user
    }

    def patients() {
        def patients = Patient.createCriteria().list {
            if (ward) {
                eq('ward', ward)
            }
            if (referralList) {
                referralLists {
                    eq 'id', referralList.id
                }
            }
            ne('status', 'Discharged')
        }
        return patients
    }
}
