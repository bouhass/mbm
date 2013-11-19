<g:applyLayout name="bootstrap">

    <div class="col-md-12">

        <div class="page-header">
            <h1>Add patient</h1>
        </div>

        <g:if test="${flash.message}">
            <bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
        </g:if>

        <g:hasErrors bean="${patientInstance}">
            <bootstrap:alert class="alert-danger">
                <ul>
                    <g:eachError bean="${patientInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                    </g:eachError>
                </ul>
            </bootstrap:alert>
        </g:hasErrors>

        <g:form action="add" method="post">
            <f:field bean="patientInstance" property="firstName" required="true" />
            <f:field bean="patientInstance" property="lastName" required="true" />
            <f:field bean="patientInstance" property="dateOfBirth" required="true"  />
            <f:field bean="patientInstance" property="gender" required="true"  />
            <f:field bean="patientInstance" property="nhsNumber" required="true"  />
            <f:field bean="patientInstance" property="ward" required="true"  />
            <hr/>
            <div class="control-group">
                <button type="submit" class="btn btn-primary">
                    <span class="glyphicon glyphicon-ok icon-white"></span>
                    Add
                </button>
            </div>
        </g:form>

    </div>

</g:applyLayout>