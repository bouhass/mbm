package pages

import com.wardbook.Patient
import geb.Page
import org.openqa.selenium.Keys

class JobListPage extends Page {

    static url = "board/ward"

    static at = {
        title ==~ /WardBook/
    }

    static content = {
    }

    def addJob(job, category, patient) {
        def jobTableId = getJobTableId(category, patient)
        $(jobTableId).find('input').value(job)
        $(jobTableId).find('input') << Keys.ENTER
    }

    def getJobs(category, patient) {
        def jobTableId = getJobTableId(category, patient)
        $(jobTableId).find('td').collect { it.text().trim() }
    }

    def getJobTableId(category, patient) {
        def patientRow = $('tr', text: contains(patient))
        "#task-${category}-${patientRow.attr('id')}"
    }
}
