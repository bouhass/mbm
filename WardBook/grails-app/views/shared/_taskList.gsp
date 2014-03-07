<%@ page import="com.wardbook.User" %>
<table id="task-${patient.id}" class="inner-table">
    <tr class="input-tr">
        <td>
            <span class="glyphicon glyphicon-plus mbm-icon-blue"></span>
        </td>
        <td>
            <input type="text" placeholder="${message(code: 'add.entry.input.default.placeholder')}" data-patient_id="${patient.id}" class="add-task-input mbm-input-blue" maxlength="60" />
        </td>
        <td></td>
    </tr>
    <g:each var="task" in="${patient.tasks.sort { it.createdDate }.reverse()}">
        <g:if test="${task.isActive()}">
            <tr>
                <td class="delete-task">
                    <button type="button" class="btn btn-delete btn-xs hidden">
                        <span class="glyphicon glyphicon-remove"></span>
                    </button>
                </td>
                <td>
                    <div data-type="task"
                         data-task-id="${task.id}"
                         data-name="${task.name}"
                         data-task-status="${task.status}"
                         data-priority="${task.priority}"
                         data-assignee="${task.assignee}"
                         data-time-due="${task.timeDue ?: ''}"
                         data-pid="${patient.id}"
                         class="editable editable-click task">
                        <a data-toggle="modal" href="${createLink(controller: 'task', action: 'partialEdit', id: task.id)}" data-target="#task-edit-modal">
                            ${task.name}<span class="task-creator"> - ${User.get(task.createdBy)}</span>
                            <g:if test="${task.comments.size > 0}">
                                <span class="glyphicon glyphicon-comment task-comment-notification">
                                    <p class="task-comment-number">${task.comments.size}</p>
                                </span>
                            </g:if>
                        </a>
                        <g:if test="${task.priority == 'URGENT'}">
                            <span class="glyphicon glyphicon-fire" style="color: orangered;"></span>
                        </g:if>
                    </div>
                </td>
                <td class="update-task-status" data-task-status="${task.status}" data-target-task-id="${task.id}">
                    <img />
                </td>
            </tr>
        </g:if>
    </g:each>
</table>