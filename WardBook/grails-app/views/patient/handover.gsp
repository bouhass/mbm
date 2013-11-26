<g:applyLayout name="board">

    <div class="third-level-nav">
        <div class="col-sm-5 col-md-5">
            %{--<ul class="nav nav-tabs nav-justified">--}%
            <ul id="view-selector" class="nav nav-tabs">
                <li><a href="#"> Doctor </a></li>
                <li><a href="#"> Nurse </a></li>
                <li><a href="#"> Physio </a></li>
                %{--<li><a data-toggle="modal" href="#customizeView"> <span class="glyphicon glyphicon-plus"></span> </a></li>--}%
            </ul>
        </div>

        <div class="col-sm-7 col-md-7">

            <div class="pull-right col-sm-4 col-md-4">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search" name="search" id="search">

                    <div class="input-group-btn">
                        <button class="btn btn-primary">
                            <span class="glyphicon glyphicon-search"></span>
                        </button>
                    </div>
                </div>
            </div>

            <div class="pull-right">
                <g:select id="referralLists" name="referralLists" from="${referralLists}" value="${params.referralList}"
                          noSelection="${ params.referralList ? ['':'- Display all -'] : ['':'- Select list -']}" />
                <g:link controller="patient" action="add" class="btn btn-primary">
                    Add patient
                </g:link>
                %{--<a data-toggle="modal" href="#customizeView" class="btn btn-default">--}%
                    %{--Edit view--}%
                %{--</a>--}%
                <a class="btn btn-primary" onclick="window.print()">
                    <span class="glyphicon glyphicon-print"></span>
                </a>
                <a id="handover" class="btn btn-primary">
                    Handover
                </a>
            </div>

        </div>
    </div>

	<div class="page-body">
		<table id="patients-table" class="patients-table bordered-table zebra-striped">
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
				<tr id="${p.id}" ${p.status.contains('Unwell') ? 'class="patient-unwell"' : ''}>
                    <td>
                        <g:render template="patientInfo" model="[patient: p]" />
                    </td>
                    <g:each var="recordType" in="['PROBLEM', 'HISTORY', 'PROGRESS', 'PLAN', 'PREMORBID', 'MOBILITY', 'SOCIAL', 'WEIGHT']">
                        <td class="${recordType}">
                            <table id="record-${recordType}-${p.id}" class="inner-table">
                                <tr>
                                    <td>
                                        <span class="glyphicon glyphicon-plus mbm-icon-blue"></span>
                                    </td>
                                    <td colspan="2">
                                        <input type="text" placeholder="Type to add" data-patient_id="${p.id}" data-type="${recordType}" class="add-record-input mbm-input-blue" maxlength="60" />
                                    </td>
                                </tr>
                                <g:each var="record" in="${p.records}">
                                    <g:if test="${record.type == recordType}">
                                        <tr>
                                            <td class="delete-record">
                                                <button type="button" class="btn btn-danger btn-xs hidden">
                                                    <span class="glyphicon glyphicon-remove"></span>
                                                </button>
                                            </td>
                                            <td data-rid="${record.id}" data-name="${record.name}" class="record">
                                                ${record.name}
                                            </td>
                                            <td class="record-date">
                                                <g:if test="${record.type in ['PROGRESS', 'PLAN', 'WEIGHT']}">
                                                    <g:formatDate format="dd/MMM" date="${record.editedDate}"/>
                                                </g:if>
                                            </td>
                                        </tr>
                                    </g:if>
                                </g:each>
                            </table>
                        </td>
                    </g:each>
				</tr>
			</g:each>
			</tbody>
		</table>

        <!-- Modal -->
        <div class="modal fade" id="customizeView" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
	</div>

    <script src="${resource(dir: 'js', file: 'patient-management.js')}"></script>

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

            $('#handover').on('click', function() {
                var $rows = $('#patients-table > tbody > tr');
                if ($(this).hasClass('active')) {
                    $rows.show();
                    $(this).removeClass('active');
                }
                else {
                    $rows.hide().filter(function() {
                        return $(this).find('input[type="checkbox"]').is(':checked');
                    }).show();
                    $(this).addClass('active');
                }
            });

            $('input.add-record-input').keyup(function (e) {
                if (e.keyCode == 13) {
                    addNewRecord($(this).val(), $(this).attr('data-patient_id'), $(this).attr('data-type'));
                    $(this).typeahead('setQuery', '');
                }
            });

            $('input.add-record-input').on('typeahead:selected', function() {
                addNewRecord($(this).val(), $(this).attr('data-patient_id'), $(this).attr('data-type'));
                $(this).typeahead('setQuery', '');
            });

            $('input.add-record-input').typeahead({
                name: 'record-names',
                prefetch: WEB_APP_ROOT+'record/names',
                remote: WEB_APP_ROOT+'record/names?q=%QUERY'
            });

            $('.delete-record').live('click', deleteRecord);

            $('.inner-table tr').live('mouseover', function() { $(this).find('.delete-record button').removeClass('hidden') });
            $('.inner-table tr').live('mouseout', function() { $(this).find('.delete-record button').addClass('hidden') });

            $('.record').each(function() {
                $(this).editable({
                    mode: 'inline',
                    type: 'text',
                    pk : $(this).attr('data-rid'),
                    url: WEB_APP_ROOT+'record/saveOrUpdate',
                    showbuttons: false,
                    params : function(params) {
                        return {
                            'id' : $(this).attr('data-rid'),
                            'name' : params.value
                        }
                    }
                });
            });

            $('#referralLists').on('change', function(e) {
                if (this.value) {
                    window.location.search = '?referralList=' + this.value;
                }
                else {
                    window.location.search = '';
                }
            });

//            window.setInterval(function() {
//                $.get(WEB_APP_ROOT+'patient/jsonlist', function(patients) {
//                    $(patients).each(function(i, patient) {
//
//                        var remoteTasks = [];
//                        $(patient.tasks).each(function(j, task) {
//                            remoteTasks.push(task.id.toString());
//                        });
//
//                        var remoteRecords = [];
//                        $(patient.records).each(function(j, record) {
//                            remoteRecords.push(record.id.toString());
//                        });
//
//                        var localTasks = [];
//                        $('tr#'+patient.id+' td').each(function() {
//                            if ($(this).attr('data-task-id') != undefined) {
//                                localTasks.push($(this).attr('data-task-id'));
//                            }
//                        })
//
//                        var localRecords = [];
//                        $('tr#'+patient.id+' td').each(function() {
//                            if ($(this).attr('data-rid') != undefined) {
//                                localRecords.push($(this).attr('data-rid'));
//                            }
//                        })
//
//                        // delete tasks if applies
//                        $(localTasks).each(function(k, taskId) {
//                            if ($.inArray(taskId, remoteTasks) == -1) {
//                                $('tr#'+patient.id+' td[data-task-id="'+taskId+'"]').parent().remove();
//                            }
//                        });
//
//                        // delete records if applies
//                        $(localRecords).each(function(k, recordId) {
//                            if ($.inArray(recordId, remoteRecords) == -1) {
//                                $('tr#'+patient.id+' td[data-rid="'+recordId+'"]').parent().remove();
//                            }
//                        });
//
//
//                        $(patient.tasks).each(function(j, task) {
//
//                            // add new tasks if applies
//                            if ($.inArray(task.id.toString(), localTasks) == -1) {
//                                $('.JOBS tbody').append('<tr><td data-task-id="'+task.id+'">'+task.name+'</td></tr>')
//                            }
//                            else {
//                                // TODO : check update required
//                                var taskElement = $('tr#'+patient.id+' td[data-task-id="'+task.id+'"]');
//                                taskElement.text(task.name);
//                            }
//                        });
//
//                        $(patient.records).each(function(j, record) {
//
//                            // add new records if applies
//                            if ($.inArray(record.id.toString(), localRecords) == -1) {
//                                addRecord(patient.id, record);
//                            }
//                            else {
//                                // TODO : check update required
//                                var recordElement = $('tr#'+patient.id+' td[data-rid="'+record.id+'"]');
//                                recordElement.text(record.name);
//                            }
//                        });
//                    })
//                })
//                        .fail(function() {
//                            console.error('ERROR: could not patient data');
//                        })
//            }, 10000);
        });
	</script>
		
</g:applyLayout>