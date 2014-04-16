$(window).load(function() {
    $('.patient-location').each(function() {
        updateEntityField(this, 'patient', 'location', 'text')
    });

    $('.patient-consultant').each(function() {
        updateEntityField(this, 'patient', 'consultant.id', 'select', {
            source: WEB_APP_ROOT+'helpers/consultants',
            emptytext: 'CONS'
        })
    });

    $('.patient-hospitalIdentifier').each(function() {
        updateEntityField(this, 'patient', 'hospitalIdentifier', 'text')
    });

    $('.patient-nhsNumber').each(function() {
        updateEntityField(this, 'patient', 'nhsNumber', 'text')
    });

    $('.patient-firstName').each(function() {
        updateEntityField(this, 'patient', 'firstName', 'text')
    });

    $('.patient-lastName').each(function() {
        updateEntityField(this, 'patient', 'lastName', 'text')
    });

    $('.patient-history').each(function() {
        updateEntityField(this, 'patient', 'history', 'textarea', {inputclass: 'editHistory-textarea'})
    });

    $('.patient-status').each(function() {
        var patientId = $(this).attr('data-id');
        updateEntityField(this, 'patient', 'status', 'select',
            {
                source: WEB_APP_ROOT+'patient/statuses',
                validate: function(value) {
                    if (value == 'Unwell') {
                        if (!confirm('FOR ACUTELY UNWELL PATIENT A VERBAL HANDOVER MUST BE DONE, CLICK YES TO CONFIRM YOU HAVE DONE SO')) {
                            return {newValue: '', msg: 'Pending verbal handover'};
                        }
                    }

                    if (value == 'Discharged') {
                        if (!confirm('ARE YOU SURE YOU WANT TO DISCHARGE THIS PATIENT?')) {
                            return {newValue: '', msg: 'Did not discharge'};
                        }
                    }
                },
                success: function(response, newValue) {
                    if (newValue.indexOf("Unwell") != -1) {
                        // for gridview
                        $('.filterable-element[id='+patientId+']').addClass('danger');
                        // for listview
                        $('.filterable-element[id='+patientId+']').removeClass('panel-info');
                        $('.filterable-element[id='+patientId+']').addClass('panel-danger');
                    }
                    else {
                        // for gridview
                        $('.filterable-element[id='+patientId+']').removeClass('danger');
                        // for listview
                        $('.filterable-element[id='+patientId+']').removeClass('panel-danger');
                        $('.filterable-element[id='+patientId+']').addClass('panel-info');
                    }
                }
            }
        );
    });

    $('.patient-handover').live('click', function() {
        $.post(WEB_APP_ROOT+'patient/partialUpdate', {
            'id': $(this).attr('data-id'),
            'handover': $(this).is(':checked')
        })
            .done(function(patient) {
                // remove loading image
            })
            .fail(function() {
//                alert("ERROR: could not update the patient");
                console.log("ERROR: could not update the patient");
            })
    });

    $('.patient-ward').each(function() {
        var patientId = $(this).attr('data-id');
        updateEntityField(this, 'patient', 'ward.id', 'select',
            {
                source: WEB_APP_ROOT+'helpers/wards',
                afterSuccess: function(response, newValue) { location.reload(); }
            }
        );
    });

    updateEntityDateField($('.patient-dob'), 'dateOfBirth', 'patient');

    $('input.add-record-input').keyup(function (e) {
        if (e.keyCode == 13) {
            addNewRecord($(this).val(), $(this).attr('data-patient_id'), $(this).attr('data-type'), $(this).attr('data-input-type'));
        }
    });

    $(".add-record-textarea").focus(function() {
        $(this).attr('rows', 10);
        $(this).val($(this).attr('placeholder'));
    });

    $(".add-record-textarea").blur(function() {
        var val = $(this).val();
        if (val.length > 0) {
            addNewRecord(val, $(this).attr('data-patient_id'), $(this).attr('data-type'), $(this).attr('data-input-type'));
            $(this).val('');
        }
        $(this).attr('rows', 2);
    });

    $('.delete-record').live('click', deleteRecord);

    $('.inner-table tr').live('mouseover', function() { $(this).find('.delete-record button').removeClass('hidden') });
    $('.inner-table tr').live('mouseout', function() { $(this).find('.delete-record button').addClass('hidden') });

    $('.record').each(function() {
        $(this).editable({
            mode: 'inline',
            type: $(this).attr('data-input-type'),
            pk : $(this).attr('data-rid'),
            url: WEB_APP_ROOT+'record/saveOrUpdate',
            showbuttons: false,
            onblur: 'submit',
            params : function(params) {
                return {
                    'id' : $(this).attr('data-rid'),
                    'name' : params.value
                }
            }
        });
    });
});
