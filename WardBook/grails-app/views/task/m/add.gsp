<g:applyLayout name="bootstrap-mobile">

    <g:set var="navTitle" value="${task.patient}" scope="request" />

    <div class="col-sm-12">

        <div class="page-header">
            <h4>Add task to ${task.patient}</h4>
        </div>

        <g:if test="${flash.message}">
            <bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
        </g:if>

        <g:hasErrors bean="${task}">
            <bootstrap:alert class="alert-danger">
                <ul>
                    <g:eachError bean="${task}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                    </g:eachError>
                </ul>
            </bootstrap:alert>
        </g:hasErrors>

        <g:form action="add" method="post">
            <div class="row">
                <input name="patient.id" value="${task.patient.id}" type="hidden" />
                <f:field bean="task" property="name" required="true" />
                <f:field bean="task" property="priority" required="true" />
                <f:field bean="task" property="assignee" />
                <div class="control-group">
                    %{--<label class="control-label" for="timeDue">Time due</label>--}%
                    %{--<div class="controls">--}%
                        %{--<g:datePicker name="timeDue" id="timeDue" relativeYears="${0..10}" precision="minute" default="none" noSelection="['':'']" />--}%
                    %{--</div>--}%
                </div>
            </div>

            <hr/>

            <button type="submit" class="btn btn-primary form-control">
                <span class="glyphicon glyphicon-ok icon-white"></span>
                Add
            </button>

        </g:form>

    </div>

</g:applyLayout>