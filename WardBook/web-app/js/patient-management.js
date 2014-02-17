$(window).load(function() {
    $('.patient-location').each(function() {
        updateBeanField(this, this, 'patient', $(this).attr('data-id'), 'location', 'text', $(this).attr('data-value'), '')
    });

    $('.patient-consultant').each(function() {
        updateBeanField(this, this, 'patient', $(this).attr('data-id'), 'consultant.id', 'select', $(this).attr('data-value'), WEB_APP_ROOT+'helpers/consultants')
    });

    $('.patient-nhsNumber').each(function() {
        updateBeanField(this, this, 'patient', $(this).attr('data-id'), 'nhsNumber', 'text', $(this).attr('data-value'), '')
    });

    $('.patient-firstName').each(function() {
        updateBeanField(this, this, 'patient', $(this).attr('data-id'), 'firstName', 'text', $(this).attr('data-value'), '')
    });

    $('.patient-lastName').each(function() {
        updateBeanField(this, this, 'patient', $(this).attr('data-id'), 'lastName', 'text', $(this).attr('data-value'), '')
    });

    $('.patient-history').each(function() {
        updateBeanField(this, this, 'patient', $(this).attr('data-id'), 'history', 'textarea', $(this).attr('data-value'), '')
    });

    $('.patient-status').each(function() {
        var patientId = $(this).attr('data-id');
        updateBeanField(this,
            this,
            'patient',
            patientId,
            'status',
            'select',
            $(this).attr('data-value'),
            WEB_APP_ROOT+'patient/statuses',
            function(value) {
                if (value == 'Unwell (Urgent Review)') {
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
            function(response, newValue) {
                if (newValue.indexOf("Unwell") != -1) {
                    $('tr[id='+patientId+']').addClass('danger');
                }
                else {
                    $('tr[id='+patientId+']').removeClass('danger');
                }
            });
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
        updateBeanField(this,
            this,
            'patient',
            patientId,
            'ward.id',
            'select',
            $(this).attr('data-value'),
            WEB_APP_ROOT+'helpers/wards',
            undefined,
            function(response, newValue) {
                location.reload();
            });
    });

    updateBeanDateField($('.patient-dob'), 'dateOfBirth', 'patient');

    $('input.add-record-input').keyup(function (e) {
        if (e.keyCode == 13) {
            addNewRecord($(this).val(), $(this).attr('data-patient_id'), $(this).attr('data-type'));
        }
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
