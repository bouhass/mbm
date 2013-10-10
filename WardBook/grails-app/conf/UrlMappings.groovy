class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		"/"(controller: 'board', action: 'handover')
		"/wardselect"(view:'/wardselect')
		"500"(view:'/error')
	}
}
