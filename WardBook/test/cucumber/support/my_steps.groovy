
import static cucumber.api.groovy.EN.*
import pages.JobListPage

Given (~'I open the job list page\$') { ->
    to JobListPage
    at JobListPage
}

When (~'I add "([^"]*)" as a (NURSE|DOCTOR) job to ([^"]*)\$') { job, category, patient ->
    page.addJob(job, category, patient)
}

Then (~'I should see "([^"]*)" as a (NURSE|DOCTOR) job assigned to ([^"]*)\$') { job, category, patient ->
    assert page.getJobs(category, patient).contains(job)
}
