<%@ page import="com.wardbook.TeamList" %>
<g:applyLayout name="bootstrap-navbar">

    <div class="col-md-4 col-md-offset-4 shadow" id="add-patient-form">

        <div class="page-header">
            <h4><span class="glyphicon glyphicon-user margin-right"></span>Add New Patient</h4>
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
                <div class="col-sm-6 col-md-6">
                    <f:field bean="patientInstance" property="firstName" required="true" />
                </div>
                <div class="col-sm-6 col-md-6">
                    <f:field bean="patientInstance" property="lastName" required="true" />
                </div>
            </div>

            <div class="row">
                <div class="col-sm-6 col-md-6">
                    <f:field bean="patientInstance" property="hospitalIdentifier" required="true" />
                </div>

                <div class="col-sm-6 col-md-6">
                    <div class="control-group">
                        <label class="control-label" for="dateOfBirth">Date Of Birth</label>
                        <div class="controls">
                            <g:datePicker name="dateOfBirth" id="dateOfBirth" relativeYears="${-100..0}" precision="day" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-12 col-md-12">
                    <f:field bean="patientInstance" property="ward" required="true" default="${request.user.ward}" />
                </div>
            </div>


            <div class="row" id="accordion">
                <h5>
                <a class="margin-left" data-toggle="collapse" data-parent="#accordion" href="#moreDetail">
                Add Optional Details <span class="glyphicon glyphicon-plus margin-left"></span></a></h5>
                <div id="moreDetail" class="collapse">
                   <div class="row">

                            <div class="col-sm-4 col-md-4">
                                <f:field bean="patientInstance" property="consultant" />
                            </div>

                            <div class="col-sm-4 col-md-4">
                                <f:field bean="patientInstance" property="location" />
                            </div>

                            <div class="col-sm-4 col-md-4">
                                <div class="control-group">
                                <label class="control-label" for="teamLists">Team lists</label>
                                    <div class="controls">
                                        <g:select from="${TeamList.list()}" name="teamLists" id="teamLists" multiple="true" optionKey="id" optionValue="name" />
                                    </div>
                                </div>

                            </div>


                   </div>

                <div class="row">
                    <div class="col-sm-4 col-md-4">
                        <f:field bean="patientInstance" property="gender" />
                    </div>

                    <div class="col-sm-4 col-md-4">
                        <f:field bean="patientInstance" property="nhsNumber" />
                    </div>

                    <div class="col-sm-4 col-md-4">
                        <f:field bean="patientInstance" property="speciality" />
                    </div>


                </div>
            </div>


            <div class="row form-action">

                <div class="col-sm-6 col-md-6">
                    <g:link controller="patient" action="listview" class="btn btn-lg btn-danger form-control">
                        <span class="glyphicon glyphicon-remove"></span>
                        Cancel
                    </g:link>
                </div>

                <div class="col-sm-6 col-md-6">
                    <button type="submit" class="btn btn-lg btn-primary form-control">
                        <span class="glyphicon glyphicon-ok icon-white"></span>
                        Add
                    </button>

                </div>
            </div>

        </g:form>

    </div>

</g:applyLayout>