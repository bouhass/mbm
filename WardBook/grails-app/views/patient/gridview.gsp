<g:applyLayout name="bootstrap-grid-layout">

    <g:render template="/shared/gridViewToolbar" model="[referralLists: referralLists]" />

    <table id="patients-table" class="table table-striped table-bordered table-hover">
        <thead>
            <tr>
                <th>DEMOGRAPHICS</th>
                <th class="HISTORY">CURRENT HISTORY</th>
                <th class="PLAN">CURRENT PLAN</th>
                <th class="WEIGHT">WEIGHT</th>
            </tr>
        </thead>
        <tbody>
        <g:each var="p" in="${patients}">
            <tr id="${p.id}" ${p.status.contains('Unwell') ? 'class="danger"' : ''} class="filterable-element">
                <td>
                    <g:render template="patientInfo" model="[patient: p]" />
                </td>
                <td>
                    <a href="#" data-id="${p.id}" data-value="${p.history}" class="patient-history">${p.history}</a>
                </td>
                <g:render template="/shared/recordList" model="[patient: p, recordType: 'PLAN', inputType: 'textarea']" />
                <g:render template="/shared/recordList" model="[patient: p, recordType: 'WEIGHT', inputType: 'text']" />
            </tr>
        </g:each>
        </tbody>
    </table>
		
</g:applyLayout>