<g:applyLayout name="bootstrap-mobile">

    <div class="row">
        <div class="col-sm-11 col-md-12">
            <ul id="view-selector" class="nav nav-tabs">
                <li class="active"><a href="javascript:;">Name</a></li>
                <li><a href="javascript:;">Loc</a></li>
                <li><a href="javascript:;">Doc</a></li>
            </ul>
        </div>
    </div>

    <div class="list-group">
        <g:if test="${!patients}">
            <a href="javascript:;" class="list-group-item">
                No patients found
            </a>
        </g:if>

        <div id="Name" class="view">
            <g:render template="m/patientList" model="[patients: patients.sort { it.lastName }, view: 'name']" />
        </div>

        <div id="Loc" class="view" style="display: none">
            <g:render template="m/patientList" model="[patients: patients.sort { it.location }, view: 'loc']" />
        </div>

        <div id="Doc" class="view" style="display: none">
            <g:render template="m/patientList" model="[patients: patients.sort { it.consultant?.name }, view: 'doc']" />
        </div>
    </div>

    <script>
        $(window).load(function() {
            $('#view-selector li').on('click', switchView);
//            $('[data-toggle=offcanvas-left]').click();
        });
    </script>

</g:applyLayout>