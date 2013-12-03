class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		"/"(controller: 'patient', action: 'handover')
		"/landingpage"(view:'/landingpage')
		"500"(view:'/error')
	}
}
