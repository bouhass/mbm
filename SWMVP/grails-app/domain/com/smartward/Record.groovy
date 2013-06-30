package com.smartward

class Record {
	
	String description
	static belongsTo = Patient

    static constraints = {
    }
	
	String toString() { "${description}" }
}
