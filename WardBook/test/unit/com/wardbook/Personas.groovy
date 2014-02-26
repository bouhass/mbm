package com.wardbook
/**
 * Created with IntelliJ IDEA.
 * User: yazid
 * Date: 06/09/2013
 * Time: 15:42
 * To change this template use File | Settings | File Templates.
 */
class Personas {

    def victoria_ward = new Ward(name: 'Victoria ward', speciality: 'Respiratory')
    def york_ward = new Ward(name: 'York ward', speciality: 'Cardiology')

    def joseph_love = new Patient(
            firstName: 'JOSEPH',
            lastName: 'LOVE',
            dateOfBirth: Date.parse("dd-MMM-yyyy", "15-Mar-1966"),
            gender: 'MALE',
            nhsNumber: '1837495756',
            status: 'For Home',
            location: 'B1B1',
            consultant: 'Dr Teo',
            speciality: 'Cardiology',
            ward: victoria_ward
    )

//    {
//        josephLove.addToTasks(new Task(name: 'Blood test', status: 'COMPLETED', category: 'NURSE'))
//        josephLove.addToTasks(new Task(name: 'X-Ray', status: 'PENDING', category: 'DOCTOR'))
//
//        josephLove.addToRecords(new Record(name: 'Diabetes', type: 'HISTORY'))
//        josephLove.addToRecords(new Record(name: 'Heart Disease', type: 'HISTORY'))
//        josephLove.addToRecords(new Record(name: 'Chest septicemia', type: 'PROBLEM'))
//        josephLove.addToRecords(new Record(name: 'Allergic to penicilin', type: 'ALERT'))
//        josephLove.addToRecords(new Record(name: 'Post-cycle, chemio 1, day 11', type: 'PROGRESS'))
//    }

        def josh_knight = new Patient(
                firstName: 'JOSH',
                lastName: 'KNIGHT',
                dateOfBirth: Date.parse("dd-MMM-yyyy", "28-Feb-1930"),
                gender: 'MALE',
                nhsNumber: '4472927495',
                status: 'No concerns',
                location: 'B2B4',
                consultant: 'Dr Teo',
                speciality: 'Cardiology',
                ward: victoria_ward
        )

//        joshKnight.addToTasks(new Task(name: 'Antibiotics allergy', status: 'PENDING', category: 'NURSE'))
//
//        joshKnight.addToRecords(new Record(name: 'AF', type: 'HISTORY'))
//        joshKnight.addToRecords(new Record(name: 'UTI', type: 'PROBLEM'))

        def anish_lee = new Patient(
                firstName: 'ANISH',
                lastName: 'LEE',
                dateOfBirth: Date.parse("dd-MMM-yyyy", "03-Jul-1980"),
                gender: 'FEMALE',
                nhsNumber: '3947672047',
                status: 'For Home',
                location: 'B3B7',
                consultant: 'Dr Teo',
                speciality: 'Cardiology',
                ward: victoria_ward
        )

//        anishLee.addToTasks(new Task(name: 'Blood pressure', status: 'STARTED', category: 'DOCTOR'))
//        anishLee.addToTasks(new Task(name: 'Feed', status: 'PENDING', category: 'NURSE'))
//
//        anishLee.addToRecords(new Record(name: 'Appendicitus', type: 'PROBLEM'))
//        anishLee.addToRecords(new Record(name: 'Does not eat', type: 'PROBLEM'))

    def ward_list = [york_ward, victoria_ward]
    def patient_list = [joseph_love, josh_knight, anish_lee]

}
