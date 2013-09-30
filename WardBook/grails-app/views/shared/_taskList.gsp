<table id="task-${category}-${patient.id}" class="inner-table">
    <tr>
        <td>
            <span class="glyphicon glyphicon-plus mbm-icon-blue"></span>
        </td>
        <td>
            <input type="text" placeholder="Type to add" data-patient_id="${patient.id}" data-category="${category}" class="add-task-input mbm-input-blue" />
        </td>
        <td></td>
    </tr>
    <g:each var="t" in="${patient.tasks}">
        <g:if test="${t.category == category}">
            <tr>
                <td class="delete-task">
                    <button type="button" class="btn btn-danger btn-xs hidden">
                        <span class="glyphicon glyphicon-remove"></span>
                    </button>
                </td>
                <td>
                    <div data-type="task"
                         data-tid="${t.id}"
                         data-name="${t.name}"
                         data-status="${t.status}"
                         data-priority="${t.priority}"
                         data-comment="${t.comment}"
                         data-category="${t.category}"
                         data-pid="${patient.id}"
                         data-popover-placement="${popoverPlacement}"
                         class="editable editable-click task">
                        ${t.name}
                        %{--&nbsp;--}%
                        %{--<span class="glyphicon glyphicon-comment task-comment-notification">--}%
                        %{--<p class="task-comment-number">1</p>--}%
                        %{--</span>--}%
                    </div>
                </td>
                <td class="update-task-status">
                    <img/>
                </td>
            </tr>
        </g:if>
    </g:each>
</table>