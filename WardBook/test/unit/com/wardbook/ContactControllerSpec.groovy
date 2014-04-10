package com.wardbook

import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import spock.lang.Specification

@TestFor(ContactController)
@Mock(Contact)
class ContactControllerSpec extends Specification {

    void "test index"() {
        when:
        controller.index()

        then:
        view == '/contact/index'
    }

    void "test add contact page"() {
        when:
        request.method = 'GET'
        controller.add()

        then:
        view == '/contact/add'
        model.contactInstance != null
    }

    void "test adding a valid contact"() {
        when:
        request.method = 'POST'
        params.name = 'bob'
        params.phoneNumber = '222-2222'
        controller.add()

        then:
        Contact.count() == 1
        def addedContact = Contact.first()
        response.redirectedUrl == "/contact/index?new=${addedContact.id}#${addedContact.id}"
        flash.message != null
    }

    void "test adding an invalid contact"() {
        when:
        request.method = 'POST'
        controller.add()

        then:
        view == '/contact/add'
        model.contactInstance != null
    }
}
