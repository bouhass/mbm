class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		"/"(controller: 'patient', action: 'handover')
		"/wardselect"(view:'/wardselect')
		"500"(view:'/error')
	}
}
