package com.wardbook

@gorm.AuditStamp
class Record {
	
	String name
    String type
    static belongsTo = [patient: Patient]

    static constraints = {
        type inList: [
                'ALERT',
                'DIET',
                'HISTORY',
                'MOBILITY',
                'NOTE',
                'PLAN',
                'PREMORBID',
                'PROBLEM',
                'PROGRESS',
                'SOCIAL',
                'WEIGHT'
        ]
    }
	
	String toString() { "${name}" }
}
