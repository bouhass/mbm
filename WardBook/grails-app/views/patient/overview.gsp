<g:applyLayout name="patient">

    <div>

        <div class="col-md-6">
            <div class="well">
                <ul class="nav nav-list">
                    <li>
                        <a href="create" class="create">
                            <span class="glyphicon glyphicon-plus"></span>
                            Add new patient
                        </a>

                        %{--<a href="#" class="create" id="openBtn">--}%
                        %{--<span class="glyphicon glyphicon-plus"></span>--}%
                        %{--<g:message code="default.create.label" args="[entityName]" />--}%
                        %{--</a>--}%

                        <%--
                        <g:link id="openBtn" class="create" action="add" data-toggle="modal" data-remote="add" data-target="#addPatientModal">
                            <span class="glyphicon glyphicon-plus"></span>
                            <g:message code="default.create.label" args="[entityName]" />
                        </g:link>
                         --%>
                    </li>
                </ul>
            </div>

            <div>
                <table class="table table-striped">
                    <tbody>
                    <g:each in="${patientInstanceList}" var="patient">
                        <tr>
                            <td>${patient.location}</td>
                            <td>${patient}</td>
                            <td>${patient.consultant}</td>
                            <td>${patient.status}</td>
                            <td>${patient.tasks.size()} jobs</td>
                            <td>
                                <a href="javascript:;" onclick="$('iframe').attr('src', '${createLink(action: 'summary', id: patient.id)}')">Show &raquo;</a>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>

                <div class="pagination">
                    <bootstrap:paginate total="${patientInstanceTotal}"/>
                </div>
            </div>
        </div>

        <div class="col-md-6" style="height: 100%">
            <iframe src="" style="
            border: 0px;
            width: 100%;
            height: 100%;
            max-height: 100%;
            "></iframe>
        </div>

        %{--<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog"--}%
             %{--style="width: 1000px; left: 500px; height: 600px;">--}%
            %{--<!----}%
				%{--<div class="modal-header">--}%
					%{--<button type="button" class="close" data-dismiss="modal">×</button>--}%
					%{--<h3>Title</h3>--}%
				%{--</div>--}%
				 %{---->--}%
            %{--<!----}%
				%{--<div class="modal-body" style="height: 90%">--}%
				 %{---->--}%
            %{--<button type="button" class="close" data-dismiss="modal">×</button>--}%
            %{--<iframe src="" frameborder="0" height="90%" width="99.6%"></iframe>--}%
            %{--<!----}%
				%{--</div> --}%
				%{--<div class="modal-footer">--}%
					%{--<button class="btn" data-dismiss="modal">OK</button>--}%
				%{--</div>--}%
				 %{---->--}%
        %{--</div>--}%

    </div>

    <script>

        $(document).ready(function () {
//            var frameSrc = WEB_APP_ROOT + 'patient/add';
//
//            $('#openBtn').click(function () {
//                $('#myModal').on('show', function () {
//
//                    $('iframe').attr("src", frameSrc);
//
//                });
//                $('#myModal').modal({show: true})
//            });

        });
    </script>

</g:applyLayout>
