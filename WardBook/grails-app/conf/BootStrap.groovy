import com.wardbook.Role
import com.wardbook.User
import com.wardbook.UserRole

import java.util.Date;

import com.wardbook.Patient
import com.wardbook.Record
import com.wardbook.Task
import com.wardbook.Ward

class BootStrap {

    def init = { servletContext ->
//        if (User.list().size() == 0) {
//            def admin_user = new User(username: 'admin@mbm.com', password: 'password')
//            admin_user.save()
//
//            def admin_role = new Role(authority: 'ROLE_ADMIN')
//            admin_role.save()
//
//            new UserRole(user: admin_user, role: admin_role).save()
//        }

//        if (Ward.list().size() == 0) {
//            def victoriaWard = new Ward(name: 'Victoria ward', speciality: 'Respiratory')
//            victoriaWard.save(failOnError: true)
//
//            def yorkWard = new Ward(name: 'York ward', speciality: 'Cardiology')
//            yorkWard.save(failOnError: true)
//        }
//
//        if (Patient.list().size() == 0) {
//            initPatientList()
//        }
    }
    def destroy = {
    }

    def initPatientList() {
        // Joseph Love
        def josephLove = new Patient(
                firstName: 'JOSEPH',
                lastName: 'LOVE',
                dateOfBirth: Date.parse("dd-MMM-yyyy", "07-Feb-1940"),
                gender: 'MALE',
                nhsNumber: '1837495756',
                status: 'For Home',
                location: 'B1B1',
                consultant: 'Dr Teo',
                speciality: 'Cardiology'
        )

        josephLove.addToTasks(new Task(name: 'Blood test', status: 'COMPLETED', category: 'NURSE'))
        josephLove.addToTasks(new Task(name: 'X-Ray', status: 'PENDING', category: 'DOCTOR'))

        josephLove.addToRecords(new Record(name: 'THN', type: 'HISTORY'))
        josephLove.addToRecords(new Record(name: 'T2DM', type: 'HISTORY'))
        josephLove.addToRecords(new Record(name: 'CKD3', type: 'HISTORY'))

        josephLove.addToRecords(new Record(name: 'CCF', type: 'PROBLEM'))
        josephLove.addToRecords(new Record(name: 'Urosepsis', type: 'PROBLEM'))

        josephLove.addToRecords(new Record(name: 'A/W: S.O.B', type: 'PROGRESS'))
        josephLove.addToRecords(new Record(name: 'Echo: EF<30%', type: 'PROGRESS'))

        josephLove.addToRecords(new Record(name: 'TTO', type: 'PLAN'))

        josephLove.addToRecords(new Record(name: 'Previously bed bound', type: 'PREMORBID'))

        josephLove.save(failOnError: true)

        // Josh Knight
        def joshKnight = new Patient(
                firstName: 'JOSH',
                lastName: 'KNIGHT',
                dateOfBirth: Date.parse("dd-MMM-yyyy", "28-Feb-1930"),
                gender: 'MALE',
                nhsNumber: '4472927495',
                status: 'Default (no concerns)',
                location: 'B2B4',
                consultant: 'Dr Teo',
                speciality: 'Cardiology',
        )

        joshKnight.addToTasks(new Task(name: 'Antibiotics allergy', status: 'PENDING', category: 'NURSE'))

        joshKnight.addToRecords(new Record(name: 'NG Tube', type: 'HISTORY'))
        joshKnight.addToRecords(new Record(name: 'IV Fluids', type: 'HISTORY'))

        joshKnight.addToRecords(new Record(name: 'CXR', type: 'PLAN'))

        joshKnight.addToRecords(new Record(name: 'MOBILE WITH ZIMMER FRAME', type: 'MOBILITY'))

        joshKnight.addToRecords(new Record(name: 'LIVES ALONE', type: 'SOCIAL'))
        joshKnight.addToRecords(new Record(name: 'CARERS QDS', type: 'SOCIAL'))

        joshKnight.save(failOnError: true)

        // Anish Lee
        def anishLee = new Patient(
                firstName: 'ANISH',
                lastName: 'LEE',
                dateOfBirth: Date.parse("dd-MMM-yyyy", "03-Jul-1980"),
                gender: 'FEMALE',
                nhsNumber: '3947672047',
                status: 'For Home',
                location: 'B3B7',
                consultant: 'Dr Teo',
                speciality: 'Respiratory'
        )

        anishLee.addToTasks(new Task(name: 'Blood pressure', status: 'STARTED', category: 'DOCTOR'))
        anishLee.addToTasks(new Task(name: 'Feed', status: 'PENDING', category: 'NURSE'))

        anishLee.addToRecords(new Record(name: 'IV Gentamicin', type: 'HISTORY'))

        anishLee.addToRecords(new Record(name: 'Appendicitus', type: 'PROBLEM'))
        anishLee.addToRecords(new Record(name: 'Does not eat', type: 'PROBLEM'))

        anishLee.addToRecords(new Record(name: 'HOIST', type: 'MOBILITY'))
        anishLee.addToRecords(new Record(name: 'HIGH FALL RISK', type: 'MOBILITY'))

        anishLee.addToRecords(new Record(name: 'Thickened fluids', type: 'DIET'))

        anishLee.save(failOnError: true)
    }
}
