package com.wardbook

class User {

    transient springSecurityService

    String username
    String password
    boolean enabled
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired

    // added fields
    String name
    static hasMany = [createdTasks: Task, assignedTasks: Task]
    static mappedBy = [createdTasks: 'creator', assignedTasks: 'assignee']

    static constraints = {
        username blank: false, unique: true
        password blank: false
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

    static def consultants() {
        def role = Role.findByAuthority('ROLE_CONSULTANT')
        def userRoles = UserRole.findAllByRole(role)
        userRoles*.user
    }
}
