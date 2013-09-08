package pages

import geb.Page

class HandoverPage extends Page {

    static url = "board/handover"

    static at = {
        title ==~ /WardBook/
    }
}
