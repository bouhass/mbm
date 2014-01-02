<g:applyLayout name="bootstrap-patient-list">

    <g:render template="/shared/patientListToolbar" model="[referralLists: referralLists]" />

    <table id="patients-table" class="table table-striped table-bordered table-hover">
        <thead>
            <tr>
                <th>PATIENT DETAILS</th>
                <th>DOCTORS JOBS</th>
                <th>NURSING JOBS</th>
            </tr>
        </thead>
        <tbody>
        <g:each var="patient" in="${patients}">
            <tr id="${patient.id}" ${patient.status.contains('Unwell') ? 'class="danger"' : ''}>
                <td>
                    <g:render template="patientInfo" model="[patient: patient]" />
                </td>
                <td>
                    <g:render template="/shared/taskList" model="[patient: patient, category: 'DOCTOR']" />
                </td>
                <td>
                    <g:render template="/shared/taskList" model="[patient: patient, category: 'NURSE']" />
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <script src="${resource(dir: 'js', file: 'task-management.js')}"></script>
		
</g:applyLayout>