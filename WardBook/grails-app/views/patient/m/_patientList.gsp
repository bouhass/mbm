<g:each in="${patients}" var="patient">
    <g:link controller="patient" action="profile" id="${patient.id}" class="list-group-item">
        ${patient} ${patient.location ? "- ${patient.location}" : ''} ${patient.consultant ? "- ${patient.consultant}" : ''}
        <div class="pull-right">
            <span class="glyphicon glyphicon-chevron-right"></span>
        </div>
    </g:link>
</g:each>