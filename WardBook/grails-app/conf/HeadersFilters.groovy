class HeadersFilters {

    def filters = {
        all(controller:'*', action:'*') {
            before = {

            }
            after = { Map model ->
                response.setHeader      "Cache-Control", "no-cache, no-store, must-revalidate"
                response.setHeader      "Pragma",        "no-cache"
                response.setDateHeader  "Expires",       0
            }
            afterView = { Exception e ->

            }
        }
    }
}
