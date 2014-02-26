import com.wardbook.ReferralList
import com.wardbook.Role
import com.wardbook.User
import com.wardbook.UserRole
import groovy.sql.Sql
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

import com.wardbook.Patient
import com.wardbook.Record
import com.wardbook.Task
import com.wardbook.Ward

class BootStrap {

    def dataSource

    def init = { servletContext ->

        if (User.list().isEmpty()) {
            def sql = new Sql(dataSource)

            sql.executeUpdate('insert into user(version, account_expired, account_locked, created_by, created_date, edited_by, edited_date, enabled, name, username, password, password_expired) ' +
                    'values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
                    ['0', false, false, '1', '2014-01-13 00:00:00', '1', '2014-01-13 00:00:00', true, 'Admin', 'admin@mbm.com', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', false])
        }

        SpringSecurityUtils.doWithAuth('admin@mbm.com') {

            if (UserRole.list().isEmpty()) {
                def admin_role = new Role(authority: 'ROLE_ADMIN')
                admin_role.save(failOnError: true)

                new Role(authority: 'ROLE_CONSULTANT').save(failOnError: true)
                new Role(authority: 'ROLE_USER').save(failOnError: true)

                new UserRole(user: User.findByName('Admin'), role: admin_role).save(failOnError: true)
            }

            if (Ward.list().isEmpty()) {
                new Ward(name: 'Blue ward', speciality: 'Cardiology').save(failOnError: true)
                new Ward(name: 'Green ward', speciality: 'Oncology').save(failOnError: true)
                new Ward(name: 'Purple ward', speciality: 'Pediatrics').save(failOnError: true)
            }

            if (ReferralList.list().isEmpty()) {
                new ReferralList(name: 'Alpha list').save(failOnError: true)
                new ReferralList(name: 'Beta list').save(failOnError: true)
                new ReferralList(name: 'Gamma list').save(failOnError: true)
            }

            if (Patient.list().isEmpty()) {
                initPatientList()
            }
        }
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
                speciality: 'Cardiology',
                ward: Ward.get(1)
        )

//        josephLove.addToTasks(new Task(name: 'Blood test', status: 'COMPLETED', category: 'NURSE'))
//        josephLove.addToTasks(new Task(name: 'X-Ray', status: 'PENDING', category: 'DOCTOR'))
//
//        josephLove.addToRecords(new Record(name: 'THN', type: 'HISTORY'))
//        josephLove.addToRecords(new Record(name: 'T2DM', type: 'HISTORY'))
//        josephLove.addToRecords(new Record(name: 'CKD3', type: 'HISTORY'))
//
//        josephLove.addToRecords(new Record(name: 'CCF', type: 'PROBLEM'))
//        josephLove.addToRecords(new Record(name: 'Urosepsis', type: 'PROBLEM'))
//
//        josephLove.addToRecords(new Record(name: 'A/W: S.O.B', type: 'PROGRESS'))
//        josephLove.addToRecords(new Record(name: 'Echo: EF<30%', type: 'PROGRESS'))
//
//        josephLove.addToRecords(new Record(name: 'TTO', type: 'PLAN'))
//
//        josephLove.addToRecords(new Record(name: 'Previously bed bound', type: 'PREMORBID'))

        josephLove.save(failOnError: true)

        // Josh Knight
        def joshKnight = new Patient(
                firstName: 'JOSH',
                lastName: 'KNIGHT',
                dateOfBirth: Date.parse("dd-MMM-yyyy", "28-Feb-1930"),
                gender: 'MALE',
                nhsNumber: '4472927495',
                status: 'No concerns',
                location: 'B2B4',
                speciality: 'Cardiology',
                ward: Ward.get(1)
        )

//        joshKnight.addToTasks(new Task(name: 'Antibiotics allergy', status: 'PENDING', category: 'NURSE'))
//
//        joshKnight.addToRecords(new Record(name: 'NG Tube', type: 'HISTORY'))
//        joshKnight.addToRecords(new Record(name: 'IV Fluids', type: 'HISTORY'))
//
//        joshKnight.addToRecords(new Record(name: 'CXR', type: 'PLAN'))
//
//        joshKnight.addToRecords(new Record(name: 'MOBILE WITH ZIMMER FRAME', type: 'MOBILITY'))
//
//        joshKnight.addToRecords(new Record(name: 'LIVES ALONE', type: 'SOCIAL'))
//        joshKnight.addToRecords(new Record(name: 'CARERS QDS', type: 'SOCIAL'))

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
                speciality: 'Respiratory',
                ward: Ward.get(1)
        )

//        anishLee.addToTasks(new Task(name: 'Blood pressure', status: 'STARTED', category: 'DOCTOR'))
//        anishLee.addToTasks(new Task(name: 'Feed', status: 'PENDING', category: 'NURSE'))
//
//        anishLee.addToRecords(new Record(name: 'IV Gentamicin', type: 'HISTORY'))
//
//        anishLee.addToRecords(new Record(name: 'Appendicitus', type: 'PROBLEM'))
//        anishLee.addToRecords(new Record(name: 'Does not eat', type: 'PROBLEM'))
//
//        anishLee.addToRecords(new Record(name: 'HOIST', type: 'MOBILITY'))
//        anishLee.addToRecords(new Record(name: 'HIGH FALL RISK', type: 'MOBILITY'))
//
//        anishLee.addToRecords(new Record(name: 'Thickened fluids', type: 'DIET'))

        anishLee.save(failOnError: true)
    }
}
