<%@ page import="com.wardbook.ReferralList" %>
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
            <div class="row">
                <div class="col-sm-6 col-md-6">
                    <f:field bean="patientInstance" property="firstName" required="true" />
                    <f:field bean="patientInstance" property="lastName" required="true" />
                    <div class="control-group">
                        <label class="control-label" for="dateOfBirth">Date Of Birth</label>
                        <div class="controls">
                            <g:datePicker name="dateOfBirth" id="dateOfBirth" relativeYears="${-100..0}" precision="day" />
                        </div>
                    </div>
                    <f:field bean="patientInstance" property="gender" required="true"  />
                    <f:field bean="patientInstance" property="nhsNumber" required="true"  />
                    <f:field bean="patientInstance" property="ward" required="true"  />
                </div>

                <div class="col-sm-6 col-md-6">
                    <h4>Optional details</h4>
                    <f:field bean="patientInstance" property="status" />
                    <f:field bean="patientInstance" property="location" />
                    <f:field bean="patientInstance" property="consultant" />
                    <f:field bean="patientInstance" property="speciality" />
                    <div class="control-group">
                        <label class="control-label" for="referralLists">Referral lists</label>
                        <div class="controls">
                            <g:select from="${ReferralList.list()}" name="referralLists" id="referralLists" multiple="true" optionKey="id" optionValue="name" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-12 col-md-12">
                <hr/>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-12 col-md-12">
                    <button type="submit" class="btn btn-primary">
                        <span class="glyphicon glyphicon-ok icon-white"></span>
                        Add
                    </button>
                </div>
            </div>

        </g:form>

    </div>

</g:applyLayout>