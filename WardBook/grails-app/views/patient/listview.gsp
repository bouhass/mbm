<g:applyLayout name="bootstrap-navbar">

    <g:render template="/shared/patientListToolbar" model="[referralLists: referralLists]" />

    <g:if test="${!request.user.ward}">

        <% def groupedPatients = patients.groupBy { it.ward } %>

        <div class="panel-group" id="groupsAccordion">
            <g:each var="group" in="${groupedPatients}">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <%-- removed (data-parent="#groupsAccordion") to be able to expand them all at the same time --%>
                        <a data-toggle="collapse" href="#collapseWard-${group.key.id}" style="text-decoration: none; :hover: text-decoration: none; color: white;"> <%-- TODO : move to css --%>
                            <h4 class="panel-title">
                                ${group.key}
                            </h4>
                        </a>
                    </div>
                    <div id="collapseWard-${group.key.id}" class="panel-collapse collapse in">
                        <div class="panel-body">
                            <% def wardPatients = groupedPatients[group.key] %>
                            <g:render template="patientsAccordion" model="[groupId: group.key.id, patients: wardPatients]" />
                        </div>
                    </div>
                </div>
            </g:each>
        </div>
    </g:if>

    <g:if test="${request.user.ward}">
        <g:render template="patientsAccordion" model="[groupId: '', patients: patients]" />
    </g:if>

    <script src="${resource(dir: 'js', file: 'patient-management.js')}"></script>
    <script src="${resource(dir: 'js', file: 'task-management.js')}"></script>

</g:applyLayout>
