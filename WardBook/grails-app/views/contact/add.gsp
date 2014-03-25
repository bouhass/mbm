<g:applyLayout name="bootstrap-navbar">

    <div class="col-md-12">

        <div class="page-header">
            <h1>Add contact</h1>
        </div>

        <g:if test="${flash.message}">
            <bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
        </g:if>

        <g:hasErrors bean="${contactInstance}">
            <bootstrap:alert class="alert-danger">
                <ul>
                    <g:eachError bean="${contactInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                    </g:eachError>
                </ul>
            </bootstrap:alert>
        </g:hasErrors>

        <g:form action="add" method="post">
            <div class="row">
                <div class="col-sm-4 col-md-4">
                    <f:field bean="contactInstance" property="name" required="true" />
                </div>

                <div class="col-sm-4 col-md-4">
                    <f:field bean="contactInstance" property="phoneNumber" required="true" />
                </div>
            </div>

            <div class="row">
                <div class="col-sm-12 col-md-12">
                    <button type="submit" class="btn btn-primary pull-right">
                        <span class="glyphicon glyphicon-ok icon-white"></span>
                        Add
                    </button>
                </div>
            </div>

        </g:form>

    </div>

</g:applyLayout>