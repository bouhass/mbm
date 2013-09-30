$(window).load(function() {
    $('#search').keyup(patientTableSearch);
    $('.patient-location').each(updatePatientLocation);
    $('.patient-consultant').each(updatePatientConsultant);
    $('.patient-status').each(updatePatientStatus);
});
