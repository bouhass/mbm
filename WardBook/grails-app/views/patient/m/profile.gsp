<g:applyLayout name="bootstrap-mobile">

    <div class="col-sm-12">
        <h4>${patient}</h4>

        <ul id="view-selector" class="nav nav-tabs">
            <li class="active"><a href="javascript:;">Tasks</a></li>
            <li><a href="javascript:;">Archive</a></li>
        </ul>
    </div>

    <div id="Tasks" class="view list-group">
        <g:each in="${patient.tasks}" var="task">
            <g:if test="${task.isActive()}">
                <g:link controller="task" action="partialEdit" id="${task.id}" class="list-group-item">
                    ${task}
                    <div class="pull-right">
                        <span class="glyphicon glyphicon-chevron-right"></span>
                    </div>
                </g:link>
            </g:if>
        </g:each>
    </div>

    <div id="Archive" class="view list-group" style="display: none">
        <g:each in="${patient.tasks}" var="task">
            <g:if test="${!task.isActive()}">
                <g:link controller="task" action="partialEdit" id="${task.id}" class="list-group-item">
                    ${task}
                    <div class="pull-right">
                        <span class="glyphicon glyphicon-chevron-right"></span>
                    </div>
                </g:link>
            </g:if>
        </g:each>
    </div>

    <script>
        $(window).load(function() {
            $('#view-selector li').on('click', switchView);
        });
    </script>

</g:applyLayout>