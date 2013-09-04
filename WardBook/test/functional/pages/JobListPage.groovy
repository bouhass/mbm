package pages

import geb.Page
import org.openqa.selenium.Keys

class JobListPage extends Page {

    static url = "board/ward"

    static at = {
        title ==~ /WardBook/
    }

    static content = {
    }

    def addJob(jobName, category, patient) {
        def jobTableId = getJobTableId(category, patient)
        $(jobTableId).find('input').value(jobName)
        $(jobTableId).find('input') << Keys.ENTER
    }

    def getJobs(category, patient) {
        def jobTableId = getJobTableId(category, patient)
        $(jobTableId).find('td', 'data-type': 'task').collect {
            [
                    name: it.text().trim(),
                    status: it.siblings().find('img').attr('src')
            ]
        }
    }

    def getJob(jobName, category, patient) {
        getJobs(category, patient).find { it.name == jobName }
    }

    def clickOnJobStatus(jobName, category, patient) {
        def jobTableId = getJobTableId(category, patient)
        def found = $(jobTableId).find('td', 'data-type': 'task').find { it.text().trim() == jobName }
        found.siblings().find('img').click()
    }

    def getJobTableId(category, patient) {
        def patientRow = $('tr', text: contains(patient))
        "#task-${category}-${patientRow.attr('id')}"
    }
}
