
import static cucumber.api.groovy.EN.*
import pages.JobListPage

Given (~'I open the job list page\$') { ->
    to JobListPage
    at JobListPage
}

When (~'I add "([^"]*)" as a (NURSE|DOCTOR) job to ([^"]*)\$') { jobName, category, patient ->
    page.addJob(jobName, category, patient)
}

Then (~'I should not see "([^"]*)" as a (NURSE|DOCTOR) job assigned to ([^"]*)\$') { jobName, category, patient ->
    sleep 200 // time for the task to get deleted
    assert page.getJob(jobName, category, patient) == null
}

Then (~'I should see "([^"]*)" as a (NURSE|DOCTOR) job assigned to ([^"]*) as ([^"]*)\$') { jobName, category, patient, status ->
}

When (~'I click on the status of the "([^"]*)" (NURSE|DOCTOR) job assigned to ([^"]*)\$') { jobName, category, patient ->
    page.clickOnJobStatus(jobName, category, patient)
}

When (~'I click on delete ([^"]*) "([^"]*)" (NURSE|DOCTOR) job$') { patient, jobName, category ->
    page.clickOnDeleteJob(jobName, category, patient)
}

def statusToImage(status) {
    switch (status) {
        case 'PENDING': return 'empty-square.png'
        case 'STARTED': return 'half-square.png'
        case 'COMPLETED': return 'full-square.png'
    }
}
