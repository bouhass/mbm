package com.wardbook

class StaffController {

    def index() {
        redirect(action: 'list')
    }

    def list() {
        [users: User.list()]
    }
}
