package com.wardbook

import spock.lang.Specification

class ConstraintUnitSpec extends Specification {

    static def alphabet = (('A'..'Z')+('0'..'9')).join()

    void validateConstraints(obj, field, error) {
        def validated = obj.validate()
        if (error && error != 'valid') {
            assert !validated
            assert obj.errors[field]
            assert error == obj.errors[field]
        } else {
            assert !obj.errors[field]
        }
    }

    def randomString(size) {
        new Random().with {
            (1..size).collect { alphabet[nextInt(alphabet.length())] }.join()
        }
    }
}
