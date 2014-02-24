<%@ page import="com.wardbook.Patient; com.wardbook.User;" %>

<g:applyLayout name="bootstrap-navbar">

    <div class="col-sm-2 col-md-2 fixed">
        <div class="row gap-bottom">
            <g:link controller="patient" action="add" class="btn btn-primary form-control">
                Add patient
            </g:link>
        </div>

        <div class="row panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Handover</h3>
            </div>
            <div class="panel-body">
                <div class="row">
                    <a id="handover" class="btn btn-primary form-control">
                        Handover
                        <span class="glyphicon glyphicon-flag"></span>
                    </a>
                </div>

                <div class="row">
                    <a id="showSignoffModal" class="btn btn-danger form-control disabled" data-toggle="modal" data-target="#signoffModal">
                        Sign off
                    </a>
                </div>
            </div>
        </div>

        <div class="row panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Filters</h3>
            </div>
            <div class="panel-body">
                <h4>Consultant</h4>
                <g:each var="consultant" in="${User.consultants()}">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="${consultant}" class="checkbox-filter" data-filter-type="consultant" onclick="javascript:filterableFilter()" />
                            ${consultant}
                        </label>
                    </div>
                </g:each>
                <div class="checkbox">
                    <label>
                        <input type="checkbox" value="Empty" class="checkbox-filter" data-filter-type="consultant" onclick="javascript:filterableFilter()" />
                        Not set
                    </label>
                </div>
                <hr/>
                <h4>Status</h4>
                <g:each var="status" in="${Patient.constraints.status.inList}">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="${status}" class="checkbox-filter" data-filter-type="status" onclick="javascript:filterableFilter()"/> ${status}
                        </label>
                    </div>
                </g:each>
            </div>
        </div>
    </div>

    <div class="col-sm-10 col-md-10" id="patient-view">

        <g:render template="/shared/listViewToolbar" model="[showPrintButton: true, showExportButton: true]" />

        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <div class="panel-title row">
                        <div class="pull-left">
                            <span class="glyphicon glyphicon-flag"></span>
                        </div>

                        <div class="col-sm-1 col-md-1">
                            LOC
                        </div>

                        <div class="col-sm-4 col-md-4">
                            Patient
                        </div>

                        <div class="col-sm-4 col-md-4">
                            Tasks
                        </div>

                        <button id="collapseExpandAll" class="btn btn-xs pull-right">
                            Expand all
                        </button>
                    </div>
                </h4>
            </div>
        </div>

        <g:if test="${!request.user.ward}">

            <% def groupedPatients = patients.groupBy { it.ward } %>

            <div class="panel-group" id="groupsAccordion">
                <g:each var="group" in="${groupedPatients}">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <%-- removed (data-parent="#groupsAccordion") to be able to expand them all at the same time --%>
                            <a data-toggle="collapse" href="#collapseWard-${group.key.id}" style="text-decoration: none; :hover: text-decoration: none; color: white;"> <%-- TODO : move to css --%>
                                <h4 class="panel-title text-center">
                                    ${group.key}
                                </h4>
                            </a>
                        </div>
                        <div id="collapseWard-${group.key.id}" class="panel-collapse collapse in">
                            <div class="panel-body no-padding">
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
    </div>

    <g:render template="/shared/handover" />

    <script src="${resource(dir: 'js', file: 'patient-management.js')}"></script>
    <script src="${resource(dir: 'js', file: 'task-management.js')}"></script>

    <script>
        $(window).load(function() {
            $('#collapseExpandAll').click(function() {
                if ($(this).text().trim() == 'Collapse all') {
                    $('.filterable-element .collapse').removeClass('in');
                    $(this).text('Expand all');
                }
                else {
                    $('.filterable-element .collapse').addClass('in');
                    $(this).text('Collapse all');
                }
            });
        });
    </script>

</g:applyLayout>
