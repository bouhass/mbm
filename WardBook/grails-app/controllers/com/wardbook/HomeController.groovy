package com.wardbook

class HomeController {

    def index() {
        if (isMobile() || request.user.ward || request.user.teamList) {
            redirect(controller: 'patient')
            return
        }
        else {
            render view: 'index'
        }
    }
}
