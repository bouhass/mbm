package com.wardbook

class ContactController {

    static scaffold = true

    def index() {
        render view: 'index'
    }

    def add() {
        switch (request.method) {
            case 'GET':
                render view: 'add', model: [contactInstance: new Contact(params)]
                break
            case 'POST':
                def contactInstance = new Contact(params)
                if (!contactInstance.save(flush: true)) {
                    render view: 'add', model: [contactInstance: contactInstance]
                    return
                }

                flash.message = message(code: 'default.created.message', args: ['Contact', contactInstance.id])
                redirect action: 'index', fragment: contactInstance.id, params: [new: contactInstance.id]
                break
        }
    }
}
