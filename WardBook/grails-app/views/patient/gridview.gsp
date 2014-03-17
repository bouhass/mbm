<g:applyLayout name="bootstrap-grid-layout">

    <g:render template="/shared/gridViewToolbar" model="[teamLists: teamLists]" />

    <table id="patients-table" class="table table-striped table-bordered table-hover print-mode">
        <thead>
            <tr>
                <th class="DEMOGRAPHICS">DEMOGRAPHICS</th>
                <th class="HISTORY">CURRENT HISTORY</th>
                <th class="PLAN">CURRENT PLAN</th>
                <th class="WEIGHT">WEIGHT</th>
                <th class="hidden">TASKS</th>
            </tr>
        </thead>
        <tbody>
        <g:each var="p" in="${patients}">
            <tr id="${p.id}" class="filterable-element ${p.status.contains('Unwell') ? 'danger' : ''}">
                <td class="DEMOGRAPHICS">
                    <g:render template="patientInfo" model="[patient: p]" />
                </td>
                <td>
                    <a href="#" data-id="${p.id}" data-value="${p.history}" class="patient-history">${p.history}</a>
                </td>

                <g:render template="/shared/recordList" model="[
                        patient: p,
                        recordType: 'PLAN',
                        inputType: 'textarea',
                        placehoder: message(code: 'add.plan.record.input.placeholder')]" />

                <g:render template="/shared/recordList" model="[
                        patient: p,
                        recordType: 'WEIGHT',
                        inputType: 'text']" />

                <td class="hidden">
                    <g:render template="/shared/taskList" model="[patient: p]" />
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <script src="${resource(dir: 'js', file: 'task-management.js')}"></script>
    <script>
        $(window).load(function() {
            if (window.location.search.indexOf('print') != -1) {
                print();
            }
        });
    </script>
		
</g:applyLayout>