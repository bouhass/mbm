<table class="patient-info">
    <tr>
        <td>
            <a href="#" data-pid="${patient.id}" data-value="${patient.location}" class="patient-location">${patient.location}</a>
        </td>
        <td>
            <g:link controller="patient" action="profile" id="${patient.id}">
                ${patient} [${patient.gender[0]}]
            </g:link>
        </td>
    </tr>
    <tr>
        <td>
            ${patient.consultant}
        </td>
        <td>
            <g:formatDate format="dd-MM-yyyy" date="${patient.dateOfBirth}"/>
            [${new Date().year - patient.dateOfBirth.year}y]
        </td>
    </tr>
    <tr>
        <td>
            ${patient.nhsNumber}
        </td>
        <td>
            <a href="#" data-pid="${patient.id}" data-value="${patient.status}" class="patient-status">${patient.status}</a>
        </td>
    </tr>
</table>