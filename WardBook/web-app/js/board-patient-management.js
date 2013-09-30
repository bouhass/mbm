$(window).load(function() {
    $('#search').keyup(patientTableSearch);
    $('.patient-location').each(updatePatientLocation);
    $('.patient-status').each(updatePatientStatus);
});
