import static grails.async.Promises.*

class SecurityFilters {

    def springSecurityService

    def filters = {
        allURIs(uri: '/**') {
            before = {
                if (springSecurityService.currentUser) {
                    request.user = springSecurityService.currentUser
                    request.user.lastSeenAt = new Date()
                    request.user.async.save(flush: true)
                }
            }
        }
    }
}
