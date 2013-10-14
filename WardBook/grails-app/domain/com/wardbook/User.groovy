package com.wardbook

import java.util.concurrent.TimeUnit

@gorm.AuditStamp
class User {

    transient springSecurityService

    static transients = ['online', 'status']

    String username
    String password
    boolean enabled
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired

    // added fields
    String name
    String phoneNumber
    Date lastSeenAt
    String grade
    Boolean onCall
    static hasMany = [createdTasks: Task, assignedTasks: Task]
    static mappedBy = [assignedTasks: 'assignee']
    static belongsTo = [ward: Ward]

    static constraints = {
        username blank: false, unique: true
        password blank: false
        phoneNumber nullable: true
        lastSeenAt nullable: true
        grade nullable: true
        onCall nullable: true
        ward nullable: true
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
}
