
class SecurityFilters {

    def springSecurityService

    def filters = {
        allURIs(uri: '/**') {
            before = {
                if (springSecurityService.isLoggedIn()) {
                    request.user = springSecurityService.currentUser
                }
            }
        }
    }
}
