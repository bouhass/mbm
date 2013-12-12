$(window).load(function() {
    $('.patient-location').each(function() {
        updateBeanField(this, this, 'patient', $(this).attr('data-id'), 'location', 'text', $(this).attr('data-value'), '')
    });

    $('.patient-consultant').each(function() {
        updateBeanField(this, this, 'patient', $(this).attr('data-id'), 'consultant.id', 'select', $(this).attr('data-value'), WEB_APP_ROOT+'helpers/consultants')
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
});
