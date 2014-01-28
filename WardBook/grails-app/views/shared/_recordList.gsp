<% def records = patient.records.sort { it.createdDate }.reverse() %>
<td class="${recordType}">
    <table id="record-${recordType}-${patient.id}" class="inner-table">
        <tr class="input-tr">
            <td>
                <span class="glyphicon glyphicon-plus mbm-icon-blue"></span>
            </td>
            <td colspan="2">
                <input type="text" placeholder="Type to add" data-patient_id="${patient.id}" data-type="${recordType}" class="add-record-input mbm-input-blue" maxlength="60" />
            </td>
        </tr>
        <g:each var="record" in="${records}">
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