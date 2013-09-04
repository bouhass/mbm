
import static cucumber.api.groovy.EN.*
import pages.JobListPage

Given (~'I open the job list page\$') { ->
    to JobListPage
    at JobListPage
}

When (~'I add "([^"]*)" as a (NURSE|DOCTOR) job to ([^"]*)\$') { jobName, category, patient ->
    page.addJob(jobName, category, patient)
}

Then (~'I should see "([^"]*)" as a (NURSE|DOCTOR) job assigned to ([^"]*) as ([^"]*)\$') { jobName, category, patient, status ->
    def job = page.getJob(jobName, category, patient)
    assert job.name == jobName
    assert job.status.contains(statusToImage(status))
}

When (~'I click on the status of the "([^"]*)" (NURSE|DOCTOR) job assigned to ([^"]*)\$') { jobName, category, patient ->
    page.clickOnJobStatus(jobName, category, patient)
}

def statusToImage(status) {
    switch (status) {
        case 'PENDING': return 'empty-square.png'
        case 'STARTED': return 'half-square.png'
        case 'COMPLETED': return 'full-square.png'
    }
}
