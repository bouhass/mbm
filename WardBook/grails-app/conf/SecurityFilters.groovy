import com.wardbook.User

class SecurityFilters {

    def springSecurityService

    def filters = {
        allURIs(uri: '/**') {
            before = {
                request.user = springSecurityService.currentUser
                request.user?.lastSeenAt = new Date()
                request.user?.save(flush: true)
            }
        }
    }
}
