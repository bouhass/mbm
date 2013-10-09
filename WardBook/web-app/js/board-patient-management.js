$(window).load(function() {
    $('#search').keyup(patientTableSearch);

    $('.patient-location').each(function() {
        updateBeanField(this, this, 'patient', $(this).attr('data-id'), 'location', 'text', $(this).attr('data-value'), '')
    });

    $('.patient-consultant').each(function() {
        updateBeanField(this, this, 'patient', $(this).attr('data-id'), 'consultant', 'select', $(this).attr('data-value'), WEB_APP_ROOT+'helpers/consultants')
    });

    $('.patient-status').each(function() {
        updateBeanField(this,
            this,
            'patient',
            $(this).attr('data-id'),
            'status',
            'select',
            $(this).attr('data-value'),
            WEB_APP_ROOT+'patient/statuses',
            function(response, newValue) {
                if (newValue == 'Unwell (Urgent Review)') {
                    alert('FOR ACUTELY UNWELL PATIENT A VERBAL HANDOVER MUST BE DONE, CLICK YES TO CONFIRM YOU HAVE DONE SO');
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
                alert("ERROR: could not update the patient");
            })
    });
});
