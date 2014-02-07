<g:applyLayout name="bootstrap-grid-layout">

    <g:render template="/shared/gridViewToolbar" model="[referralLists: referralLists]" />

    <div class="row hidden hidden-print">
        <div class="hidden-sm col-md-12">
            <ul id="view-selector" class="nav nav-tabs" style="border-bottom: 0px;">
                <li><a href="#"> Doctor </a></li>
                <li><a href="#"> Nurse </a></li>
                <li><a href="#"> Physio </a></li>
                <li><a data-toggle="modal" href="#customizeView"> <span class="glyphicon glyphicon-plus"></span> </a></li>
            </ul>
        </div>
    </div>

    <table id="patients-table" class="table table-striped table-bordered table-hover">
        <thead>
            <tr>
                <th>PATIENT DETAILS - [I]</th>
                <th class="PROBLEM">PROBLEM LIST - [S]</th>
                <th class="HISTORY">PMH - [B]</th>
                <th class="PROGRESS">PROGRESS - [A]</th>
                <th class="PLAN">PLAN - [R]</th>
                <th class="PREMORBID">PRE-MORBID STATUS</th>
                <th class="MOBILITY">MOBILITY</th>
                <th class="SOCIAL">SOCIAL</th>
                <th class="WEIGHT">WEIGHT</th>
            </tr>
        </thead>
        <tbody>
        <g:each var="p" in="${patients}">
            <tr id="${p.id}" ${p.status.contains('Unwell') ? 'class="danger"' : ''} class="filterable-element">
                <td>
                    <g:render template="patientInfo" model="[patient: p]" />
                </td>
                <g:each var="recordType" in="['PROBLEM', 'HISTORY', 'PROGRESS', 'PLAN', 'PREMORBID', 'MOBILITY', 'SOCIAL', 'WEIGHT']">
                    <g:render template="/shared/recordList" model="[patient: p, recordType: recordType]" />
                </g:each>
            </tr>
        </g:each>
        </tbody>
    </table>

    <!-- Modal -->
    <div class="modal fade hidden-print" id="customizeView" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Customize your view</h4>
                </div>
                <div class="modal-body">
                    <span class="glyphicon glyphicon-search" style="color: #3cf"></span>
                    &nbsp;
                    <input type="text" placeholder="Search for column" class="mbm-input-blue" />
                    <form role="form">
                        <!-- TODO : replace with Record type inList enum -->
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" value="PROBLEM"> PROBLEM LIST
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" value="PROGRESS"> PROGRESS
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" value="PLAN"> PLAN
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" value="WEIGHT"> WEIGHT
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" value="NOTE"> NOTES
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" value="DIET"> DIET
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" value="PREMORBID"> PRE-MORBID STATUS
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" value="MOBILITY"> MOBILITY
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" value="SOCIAL"> SOCIAL
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox"> RESUS STATUS
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox"> CONTINENCE
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox"> EWS
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox"> DATE OF ADMISSION
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox"> DISCHARGE PLAN
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox"> MRSA
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox"> PDD
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox"> DATE OF ARRIVAL
                            </label>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Save <span class="glyphicon glyphicon-chevron-right"></span></button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Save as new <span class="glyphicon glyphicon-chevron-right"></span></button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

	<script>
        function displaySelectedView() {
            var handoverViewsColumnsMapping;
            switch (window.orientation) {
                case 0:
                case 180:
                    handoverViewsColumnsMapping = {
                        Doctor: ['PROBLEM', 'HISTORY'],
                        Nurse: ['PROBLEM', 'HISTORY'],
                        Physio: ['PROBLEM', 'HISTORY']
                    };
                    break;
                default:
                    if ($(window).width() > 1024) {
                        handoverViewsColumnsMapping = {
                            Doctor: ['PROBLEM', 'HISTORY', 'PROGRESS', 'PLAN', 'WEIGHT'],
                            Nurse: ['PROBLEM', 'HISTORY', 'MOBILITY', 'SOCIAL', 'WEIGHT'],
                            Physio: ['PROBLEM', 'HISTORY', 'MOBILITY', 'PREMORBID', 'WEIGHT']
                        }
                    }
                    else {
                        handoverViewsColumnsMapping = {
                            Doctor: ['PROBLEM', 'HISTORY', 'PROGRESS', 'PLAN'],
                            Nurse: ['PROBLEM', 'HISTORY', 'MOBILITY', 'SOCIAL'],
                            Physio: ['PROBLEM', 'HISTORY', 'MOBILITY', 'PREMORBID']
                        }
                    }
                    break;
            }

            $(['PROBLEM', 'HISTORY', 'PROGRESS', 'PLAN', 'WEIGHT', 'PREMORBID', 'MOBILITY', 'SOCIAL']).each(function(j, columnToHide) {
                $('.'+columnToHide).hide();
            });
            $('#customizeView input').attr('checked', false);

            var selectedView = $('#view-selector li[class=active]').text().trim();
            $(handoverViewsColumnsMapping[selectedView]).each(function(i, columnName) {
                $('.'+columnName).show();
                $('#customizeView input[value='+columnName+']').attr('checked', true);
            });
        }

        window.addEventListener('orientationchange', function() {
            document.activeElement.blur();
            setTimeout(displaySelectedView, 300);
        });

		$(window).load(function() {

            $(['PROBLEM', 'HISTORY', 'PROGRESS', 'PLAN', 'WEIGHT', 'PREMORBID', 'MOBILITY', 'SOCIAL']).each(function(j, columnToHide) {
                $('.'+columnToHide).hide();
            });

            $('#view-selector li a:not([data-toggle])').on('click', function() {
                $(this).parent().siblings().removeClass('active');
                $(this).parent().addClass('active');
                displaySelectedView();
            });

            $('#view-selector li a:contains(Doctor)').click();
        });
	</script>
		
</g:applyLayout>