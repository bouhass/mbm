package com.wardbook

class HomeController {

    def index() {
        if (isMobile() || request.user.ward || request.user.referralList) {
            redirect(controller: 'patient')
            return
        }
        else {
            render view: 'index'
        }
    }
}
