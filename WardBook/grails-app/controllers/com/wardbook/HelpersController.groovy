package com.wardbook

import grails.converters.JSON

class HelpersController {

    def consultants() {
        render User.consultants()*.name as JSON
    }
}
