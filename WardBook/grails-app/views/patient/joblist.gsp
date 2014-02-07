<g:applyLayout name="bootstrap-grid-layout">

    <g:render template="/shared/gridViewToolbar" model="[referralLists: referralLists]" />

    <table id="patients-table" class="table table-striped table-bordered table-hover">
        <thead>
            <tr>
                <th>PATIENT DETAILS</th>
                <th>JOBS</th>
            </tr>
        </thead>
        <tbody>
        <g:each var="patient" in="${patients}">
            <tr id="${patient.id}" ${patient.status.contains('Unwell') ? 'class="danger"' : ''}>
                <td>
                    <g:render template="patientInfo" model="[patient: patient]" />
                </td>
                <td>
                    <g:render template="/shared/taskList" model="[patient: patient]" />
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <script src="${resource(dir: 'js', file: 'task-management.js')}"></script>
		
</g:applyLayout>