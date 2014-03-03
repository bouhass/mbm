<%@ page import="com.wardbook.TeamList" %>
<g:applyLayout name="bootstrap-navbar">

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
            <div class="row">
                <div class="col-sm-2 col-md-2">
                    <f:field bean="patientInstance" property="firstName" required="true" />
                </div>

                <div class="col-sm-2 col-md-2">
                    <f:field bean="patientInstance" property="lastName" required="true" />
                </div>

                <div class="col-sm-2 col-md-2">
                    <f:field bean="patientInstance" property="hospitalIdentifier" required="true" />
                </div>

                <div class="col-sm-3 col-md-3">
                    <div class="control-group">
                        <label class="control-label" for="dateOfBirth">Date Of Birth</label>
                        <div class="controls">
                            <g:datePicker name="dateOfBirth" id="dateOfBirth" relativeYears="${-100..0}" precision="day" />
                        </div>
                    </div>
                </div>

                <div class="col-sm-3 col-md-3">
                    <f:field bean="patientInstance" property="ward" required="true" default="${request.user.ward}" />
                </div>
            </div>

            <div class="row"><br/></div>

            <div class="row">
                <h4>Optional details</h4>

                <div class="col-sm-3 col-md-3">
                    <f:field bean="patientInstance" property="consultant" />
                </div>

                <div class="col-sm-3 col-md-3">
                    <f:field bean="patientInstance" property="location" />
                </div>

                <div class="col-sm-3 col-md-3">
                    <f:field bean="patientInstance" property="nhsNumber" />
                </div>

                <div class="col-sm-3 col-md-3">
                    <f:field bean="patientInstance" property="status" />
                </div>
            </div>

            <div class="row">
                <div class="col-sm-3 col-md-3">
                    <f:field bean="patientInstance" property="gender" />
                </div>

                <div class="col-sm-3 col-md-3">
                    <div class="control-group">
                        <label class="control-label" for="teamLists">Team lists</label>
                        <div class="controls">
                            <g:select from="${TeamList.list()}" name="teamLists" id="teamLists" multiple="true" optionKey="id" optionValue="name" />
                        </div>
                    </div>
                </div>

                <div class="col-sm-3 col-md-3">
                    <f:field bean="patientInstance" property="speciality" />
                </div>

                <div class="col-sm-3 col-md-3">
                </div>
            </div>

            <div class="row">
                <div class="col-sm-12 col-md-12">
                <hr/>
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