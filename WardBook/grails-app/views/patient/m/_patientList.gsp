<g:each in="${patients}" var="patient">
    <g:link controller="patient" action="profile" id="${patient.id}" class="list-group-item ${patient.status.contains('Unwell') ? 'danger' : ''}">
        ${patient.firstName}
        <span ${view == 'name' ? 'style="font-weight: bold;"' : ''}>${patient.lastName}</span>
        <span ${view == 'loc' ? 'style="font-weight: bold;"' : ''}>${patient.location ? "- ${patient.location}" : ''}</span>
        <span ${view == 'doc' ? 'style="font-weight: bold;"' : ''}>${patient.consultant ? "- ${patient.consultant}" : ''}</span>
        <br/>
        ${new Date().year - patient.dateOfBirth.year}y -
        ${patient.gender ? patient.gender[0] : ''}
        ${patient.tasks.findAll { it.isActive() }.size()} tasks
        <div class="list-chevron-right">
            <span class="glyphicon glyphicon-chevron-right"></span>
        </div>
    </g:link>
</g:each>