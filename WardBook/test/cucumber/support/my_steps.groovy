
import static cucumber.api.groovy.EN.*
import pages.JobListPage

Given (~'I open the job list page\$') { ->
    to JobListPage
    at JobListPage
}

When (~'I add "([^"]*)" as a (NURSE|DOCTOR) job to ([^"]*)\$') { jobName, category, patient ->
    sleep 300 // needed to be able to add a job
    page.addJob(jobName, category, patient)
}

Then (~'I should not see "([^"]*)" as a (NURSE|DOCTOR) job assigned to ([^"]*)\$') { jobName, category, patient ->
    sleep 300 // time for the task to get deleted
    assert page.getJob(jobName, category, patient) == null
}

Then (~'I should see "([^"]*)" as a (NURSE|DOCTOR) job assigned to ([^"]*) as ([^"]*)\$') { jobName, category, patient, status ->
    def job = page.getJob(jobName, category, patient)
    assert job.name == jobName
    assert job.status.contains(statusToImage(status))
}

When (~'I click on the status of the "([^"]*)" (NURSE|DOCTOR) job assigned to ([^"]*)\$') { jobName, category, patient ->
    page.clickOnJobStatus(jobName, category, patient)
}

When (~'I click on delete ([^"]*) "([^"]*)" (NURSE|DOCTOR) job$') { patient, jobName, category ->
    page.clickOnDeleteJob(jobName, category, patient)
}

def statusToImage(status) {
    switch (status) {
        case 'PENDING':     return 'check-square-PENDING.png'
        case 'STARTED':     return 'check-square-STARTED.png'
        case 'COMPLETED':   return 'check-square-COMPLETED.png'
    }
}
