<%@ page import="com.wardbook.Patient; com.wardbook.User; com.wardbook.ReferralList; com.wardbook.Ward" %>

<head>
    <title>${request.user.ward ? request.user.ward : request.user.referralList}</title>
</head>

<g:applyLayout name="bootstrap-navbar">

    <div class="col-sm-2 col-md-2">
        <div class="row">
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
                            <input checked="true" type="checkbox" value="${consultant}" class="patient-filter" data-filter-type="consultant" onclick="javascript:filterPatients()" />
                            ${consultant}
                        </label>
                    </div>
                </g:each>
                <div class="checkbox">
                    <label>
                        <input checked="true" type="checkbox" value="Empty" class="patient-filter" data-filter-type="consultant" onclick="javascript:filterPatients()" />
                        Not set
                    </label>
                </div>
                <hr/>
                <h4>Status</h4>
                <g:each var="status" in="${Patient.constraints.status.inList}">
                    <div class="checkbox">
                        <label>
                            <input checked="true" type="checkbox" value="${status}" class="patient-filter" data-filter-type="status" onclick="javascript:filterPatients()"/> ${status}
                        </label>
                    </div>
                </g:each>
            </div>
        </div>
    </div>

    <div class="col-sm-10 col-md-10">
        <div class="row">

            <div class="col-sm-7 col-md-7" style="margin-left: -15px;">
                <div class="btn-group">
                    <button type="button" class="btn btn-link btn-lg dropdown-toggle" data-toggle="dropdown">
                        <h3>
                            ${
                                request.user.ward ?
                                    request.user.ward :
                                    request.user.referralList ?
                                        request.user.referralList :
                                        'All patients' }
                            <span class="caret"></span>
                        </h3>
                    </button>
                    <ul class="dropdown-menu" role="menu" style="width: 480px;">
                        <div class="row">
                            <div class="col-md-6">
                                <h4>Wards</h4>
                                <li class="divider"></li>
                                <g:each in="${Ward.list()}" var="ward">
                                    <li>
                                        <a href='javascript: switchWard(${ward.id})'>${ward}</a>
                                    </li>
                                </g:each>
                            </div>
                            <div class="col-md-6">
                                <h4>Lists</h4>
                                <li class="divider"></li>
                                <g:each in="${ReferralList.list()}" var="referralList">
                                    <li>
                                        <a href='javascript: switchList(${referralList.id})'>${referralList}</a>
                                    </li>
                                </g:each>
                            </div>
                        </div>

                        <div class="row col-md-12">
                            <hr/>
                            <a href='javascript: switchWard()'>Show all patients</a>
                        </div>
                    </ul>
                </div>
            </div>

            <div class="pull-right col-sm-4 col-md-4" style="margin-right: -15px;">
                <div>
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Search" name="search" id="search">

                        <div class="input-group-btn">
                            <button class="btn btn-primary">
                                <span class="glyphicon glyphicon-search"></span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="pull-right">
                <a class="btn btn-primary" onclick="window.print()">
                    <span class="glyphicon glyphicon-print"></span>
                </a>
            </div>

        </div>
        <div class="row"></div>

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
    </div>

    <g:render template="/shared/handover" />

    <script src="${resource(dir: 'js', file: 'patient-management.js')}"></script>
    <script src="${resource(dir: 'js', file: 'task-management.js')}"></script>
    <script>
        $(window).load(function() {
            $('#search').keyup(patientListSearch);
        });
    </script>

</g:applyLayout>
