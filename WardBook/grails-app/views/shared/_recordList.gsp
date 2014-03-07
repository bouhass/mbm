<%
    def records = patient.records.sort { it.createdDate }.reverse()
    def cropped = false
    if (!showAllEntries && (records.size > 3)) {
        cropped = true
        records = records[0..2]
    }
%>
<td class="${recordType}">
    <table id="record-${recordType}-${patient.id}" class="inner-table">

        <g:if test="${inputType == 'textarea'}">
            <tr class="input-tr">
                <textarea class="form-control add-record-textarea"
                          data-patient_id="${patient.id}"
                          data-type="${recordType}"
                          data-input-type="${inputType}"
                          placeholder="${placehoder ?: 'Type to add'}"
                          rows="3"></textarea>
            </tr>
        </g:if>

        <g:if test="${inputType == 'text'}">
            <tr class="input-tr">
                <td>
                    <span class="glyphicon glyphicon-plus mbm-icon-blue"></span>
                </td>
                <td colspan="2">
                    <input type="text"
                           placeholder="${placehoder ?: 'Type to add'}"
                           data-patient_id="${patient.id}"
                           data-type="${recordType}"
                           data-input-type="${inputType}"
                           class="add-record-input mbm-input-blue"
                           maxlength="60" />
                </td>
            </tr>
        </g:if>

        <g:each var="record" in="${records}">
            <g:if test="${record.type == recordType}">
                <tr>
                    <td class="delete-record">
                        <button type="button" class="btn btn-delete btn-xs hidden">
                            <span class="glyphicon glyphicon-remove"></span>
                        </button>
                    </td>
                    <td data-rid="${record.id}" data-name="${record.name}" data-input-type="${inputType}" class="record">${record.name}</td>
                    <td class="record-date">
                        <g:if test="${record.type in ['PROGRESS', 'PLAN', 'WEIGHT']}">
                            <g:formatDate format="dd/MMM" date="${record.editedDate}"/>
                        </g:if>
                    </td>
                </tr>
            </g:if>
        </g:each>

        <g:if test="${cropped}">
            <tr>
                <td></td>
                <td>
                    <g:link controller="patient" action="profile" id="${patient.id}" fragment="${recordType}">
                        Show more ...
                    </g:link>
                </td>
            </tr>
        </g:if>

    </table>
</td>