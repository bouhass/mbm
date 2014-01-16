import com.wardbook.User

class SecurityFilters {

    def springSecurityService

    def filters = {
        allURIs(uri: '/**') {
            before = {
                if (springSecurityService.isLoggedIn()) {
                    request.user = User.get(springSecurityService.principal.id)
                    springSecurityService.currentUser.lastSeenAt = new Date()
                }
            }
        }
    }
}
