package com.wardbook

class Record {
	
	String name
    String type
    static belongsTo = [patient: Patient]

    static constraints = {
        type inList: ['HISTORY', 'PROBLEM', 'ALERT', 'PROGRESS']
    }
	
	String toString() { "${description}" }
}
