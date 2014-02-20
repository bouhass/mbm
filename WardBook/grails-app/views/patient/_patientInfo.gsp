<table class="patient-info">
    <tr>
        <td>
            <a href="#" data-id="${patient.id}" data-value="${patient.location}" class="patient-location">${patient.location}</a>
        </td>
        <td>
            <g:link controller="patient" action="profile" id="${patient.id}">
                ${patient} [${patient.gender ? patient.gender[0] : ''}]
            </g:link>
        </td>
    </tr>
    <tr>
        <td>
            <a href="#" data-id="${patient.id}" data-value="${patient.consultant}" class="patient-consultant">${patient.consultant}</a>
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
            <a href="#" data-id="${patient.id}" data-value="${patient.status}" class="patient-status">${patient.status}</a>
        </td>
    </tr>
    <tr>
        <td>
            Handover <input type="checkbox" data-id="${patient.id}" ${patient.handover ? 'checked' : ''} class="patient-handover">
        </td>
        <td>
            <a href="#" data-id="${patient.id}" data-value="${patient.ward?.id}" class="patient-ward">${patient.ward?.name}</a>
        </td>
    </tr>
</table>