import java.util.Date;

import com.smartward.Patient
import com.smartward.Record
import com.smartward.Task

class BootStrap {

    def init = { servletContext ->
		
		// Joseph Love
		def josephLove = new Patient(
			firstName: 'JOSEPH', 
			lastName: 'LOVE', 
			dateOfBirth: Date.parse("dd-MMM-yyyy", "15-Mar-1966"),
			gender: 'MALE',
			nhsNumber: '18374957563', 
			status: 'For Home', 
			location: 'B1B1',
			consultant: 'Dr Teo',
			speciality: 'Cardiology',
			records: [
				new Record(description: 'High blood pressure')
			]
			)
		
		josephLove.addToTasks(new Task(name: 'Blood test', status: 'PENDING', category: 'NURSE'))
		josephLove.addToTasks(new Task(name: 'X-Ray', status: 'PENDING', category: 'DOCTOR'))
		
		josephLove.save(failOnError: true)
		
		// Josh Knight
		def joshKnight = new Patient(
			firstName: 'JOSH',
			lastName: 'KNIGHT',
			dateOfBirth: Date.parse("dd-MMM-yyyy", "28-Feb-1930"),
			gender: 'MALE',
			nhsNumber: '447292749509573',
			status: 'Default (no concerns)',
			location: 'B2B4',
			consultant: 'Dr Teo',
			speciality: 'Cardiology',
			records: [
				new Record(description: 'Allergy to peniciline')
			]
			)
		
		joshKnight.addToTasks(new Task(name: 'Antibiotics allergy', status: 'PENDING', category: 'NURSE'))
		
		joshKnight.save(failOnError: true)
		
		// Anish Lee
		def anishLee = new Patient(
			firstName: 'ANISH',
			lastName: 'LEE',
			dateOfBirth: Date.parse("dd-MMM-yyyy", "03-Jul-1980"),
			gender: 'FEMALE',
			nhsNumber: '39476720475853',
			status: 'For Home',
			location: 'B3B7',
			consultant: 'Dr Teo',
			speciality: 'Cardiology',
			records: [
				new Record(description: 'Appendicitus'),
				new Record(description: 'Heart issues'),
				new Record(description: 'Does not eat')
			]
			)
		
		anishLee.addToTasks(new Task(name: 'Blood pressure', status: 'PENDING', category: 'DOCTOR'))
		anishLee.addToTasks(new Task(name: 'Feed', status: 'PENDING', category: 'NURSE'))
		
		anishLee.save(failOnError: true)
		
    }
    def destroy = {
    }
}
