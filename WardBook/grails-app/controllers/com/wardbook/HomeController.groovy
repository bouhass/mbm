package com.wardbook

class HomeController {

    def index() {
        if (isMobile()) {
            redirect(controller: 'patient')
            return
        }
    }
}
