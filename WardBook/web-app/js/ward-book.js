
function taskStatusToImage(status) {
    if      (status == 'STARTED')    return WEB_APP_ROOT+'images/check-square-STARTED.png';
    else if (status == 'COMPLETED')  return WEB_APP_ROOT+'images/check-square-COMPLETED.png';
    else /* (status == 'PENDING') */ return WEB_APP_ROOT+'images/check-square-PENDING.png';
}

var updateTaskStatus = function() {
    var self = $(this)
    self.children('img').attr('src', WEB_APP_ROOT+'images/spinner.gif');
    var taskElement = $('[data-task-id="'+self.attr('data-target-task-id')+'"]');
    var taskId = taskElement.attr('data-task-id');
    var currentStatus = taskElement.attr('data-task-status');
    var newStatus = {
        'PENDING': 'STARTED',
        'STARTED': 'COMPLETED',
        'COMPLETED': 'PENDING'
    }[currentStatus]

    $.post(WEB_APP_ROOT+'task/partialUpdate', {
        'id': taskId,
        'status': newStatus
    })
        .done(function(task) {
            self.children('img').attr('src', taskStatusToImage(task.status));
            taskElement.attr('data-task-status', task.status);
        })
        .fail(function() {
//            alert("ERROR: could not update the task status");
            console.error("ERROR: could not update the task status");
        })
}

var deleteTask = function() {
    var self = $(this);
    var taskElement = $(self.siblings()[0]).children('div');
    if (confirm('Are you sure you want to delete this job? ('+taskElement.attr('data-name')+')')) {
        self.children().removeClass('glyphicon');
        self.children().removeClass('glyphicon-remove');
        self.append('<img src="'+WEB_APP_ROOT+'images/spinner.gif" />');
        var taskId = taskElement.attr('data-task-id');
        $.get(WEB_APP_ROOT+'task/delete/'+taskId)
            .done(function(task) {
                self.parent().remove();
            })
            .fail(function() {
                self.children('img').remove();
                self.children().addClass('glyphicon');
                self.children().addClass('glyphicon-remove');
//                alert("ERROR: could not delete task");
                console.log("ERROR: could not delete task");
            })
    }
}

var deleteRecord = function() {
    var self = $(this);
    var taskElement = self.siblings();
    if (confirm('Are you sure you want to delete this record? ('+taskElement.attr('data-name')+')')) {
        self.children().removeClass('glyphicon');
        self.children().removeClass('glyphicon-remove');
        self.append('<img src="'+WEB_APP_ROOT+'images/spinner.gif" />');
        var recordId = taskElement.attr('data-rid');
        $.get(WEB_APP_ROOT+'record/delete/'+recordId)
            .done(function(record) {
                self.parent().remove();
            })
            .fail(function() {
                self.children('img').remove();
                self.children().addClass('glyphicon');
                self.children().addClass('glyphicon-remove');
//                alert("ERROR: could not delete task");
                console.log("ERROR: could not delete task");
            })
    }
}

function addTask(patient_id, task) {
    var taskNameId = 'task-name-id'+new Date().getTime();
    var taskImageId = 'task-image'+new Date().getTime();
    var taskDeleteId = 'task-delete'+new Date().getTime();
    var taskElement = '' +
        '<tr>' +
            '<td id="'+taskDeleteId+'" class="delete-task"><button type="button" class="btn btn-danger btn-xs hidden"><span class="glyphicon glyphicon-remove"></span></button></td>' +
            '<td>' +
                '<div id="'+taskNameId+'" data-type="task" data-task-id="'+task.id+'" data-task-status="PENDING" data-name="'+task.name+'" data-priority="NORMAL" class="editable editable-click task">' +
                    '<a data-toggle="modal" href="'+WEB_APP_ROOT+'task/partialEdit/'+task.id+'" data-target="#task-edit-modal">'+
                        task.name+
                        '<span class="task-creator"> - '+CURRENT_USER_NAME+'</span>'+
                    '</a>' +
                '</div>' +
            '</td>' +
            '<td id="'+taskImageId+'" class="update-task-status" data-target-task-id="'+task.id+'"><img src="'+taskStatusToImage(task.status)+'"/></td>' +
        '</tr>';
    $(taskElement).insertAfter($('#task-'+patient_id+' tbody .input-tr'));
}

function addNewTask(name, patient_id, afterSuccess) {
    if (name.length == 0) {
        console.error("ERROR: attempting to add a task with no name");
        return;
    }

    $.post(WEB_APP_ROOT+'task/saveOrUpdate', {
        'name': name,
        'patient.id': patient_id
    })
        .done(function(task) {
            if (afterSuccess == undefined) {
                addTask(patient_id, task);
            }
            else {
                afterSuccess(patient_id, task);
            }
        })
        .fail(function() {
//            alert("ERROR: could not add the task");
            console.log("ERROR: could not add the task");
        })
}

function addRecord(patient_id, record) {
    var id = new Date().getTime();

    var recordElement = '' +
        '<tr>' +
          '<td class="delete-record"><button type="button" class="btn btn-danger btn-xs hidden"><span class="glyphicon glyphicon-remove"></span></button></td>' +
          '<td id="'+id+'" data-rid="'+record.id+'" data-name="'+record.name+'" class="record">'+record.name+'</td>' +
        '</tr>';

    $(recordElement).insertAfter('#record-'+record.type+'-'+patient_id+' .input-tr');

    $('[data-rid='+record.id+']').editable({
        mode: 'inline',
        type: 'text',
        pk : record.id,
        url: WEB_APP_ROOT+'record/saveOrUpdate',
        showbuttons: false,
        params : function(params) {
            return {
                'id' : record.id,
                'name' : params.value
            }
        }
    });
}

function addNewRecord(name, patient_id, type) {
    if (name.length == 0) {
        console.error("ERROR: attempting to add a record with no name");
        return;
    }

    $.post(WEB_APP_ROOT+'record/saveOrUpdate', {
        'name': name,
        'type': type,
        'patient.id': patient_id
    })
        .done(function(record) {
            addRecord(patient_id, record);
        })
        .fail(function() {
//            alert("ERROR: could not add the task");
            console.log("ERROR: could not add the task");
        })
}

var filterableSearch = function() {
    var $rows = $('.filterable-element');
    var val = $.trim($(this).val()).replace(/ +/g, ' ').toLowerCase();

    $rows.show().filter(function() {
        var text = $(this).text().replace(/\s+/g, ' ').toLowerCase();
        return !~text.indexOf(val);
    }).hide();
}

function filterableFilter() {
    var checkedElements = $('.checkbox-filter:checked');
    if (checkedElements.size() == 0) {
        $('.filterable-element').show();
    }
    else {
        $('.filterable-element').show().filter(function() {
            var filterableElement = $(this);
            var hide = true;
            checkedElements.each(function() {
                var filterType = $(this).attr('data-filter-type');
                var value;
                if ($(this).attr('data-filter-mode') == 'attribute') {
                    value = filterableElement.find('[data-'+filterType+']').attr('data-'+filterType);
                }
                else { // text based
                    value = filterableElement.find('.filterable-'+filterType).text().trim();
                }

                if (value == $(this).attr('value')) {
                    hide = false;
                    return false; // to break from the each
                }
            });
            return hide;
        }).hide();
    }
}

function updateBeanField(element, bean, beanType, beanId, field, fieldType, fieldValue, source, validate, afterSuccess) {
    $(element).editable({
        mode: 'inline',
        type: fieldType,
        pk : beanId,
        url: WEB_APP_ROOT+beanType+'/partialUpdate',
        value: fieldValue,
        source: source,
        showbuttons: false,
        params: function(params) {
            var ret = {};
            ret['id'] = beanId;
            ret[field] = params.value;
            return ret;
        },
        validate: function(value) {
            if (validate != undefined) {
                return validate(value);
            }
        },
        success: function(response, newValue) {
            if (afterSuccess != undefined) {
                afterSuccess(response, newValue);
            }
            $(bean).attr('data-'+field, newValue);
        }
    });
}

function updateBeanDateField(element, field, beanType) {
    $(element).editable({
        mode: 'inline',
        format: "YYYY-MM-DD",
        viewformat: "DD-MM-YYYY",
        template: "D MMM YYYY ",
        combodate: {
            minYear: 1900,
            maxYear: (new Date()).getFullYear()
        },
        url: WEB_APP_ROOT+beanType+'/partialUpdate',
        params : function(params) {
            var parsedDate = params['value'].match(/^(\d{4})-(\d{2})-(\d{2})$/)
            var ret = {};
            ret['id'] = $(element).attr('data-'+beanType+'-id');
            ret[field] = 'date.struct';
            ret[field+'_day'] = parsedDate[3];
            ret[field+'_month'] = parsedDate[2];
            ret[field+'_year'] = parsedDate[1];
            return ret;
        }
    });
}

function updateBeanDateTimeField(element, field, beanType) {
    $(element).editable({
        mode: 'inline',
        format: "YYYY-MM-DD HH:mm",
        viewformat: "D MMM, YYYY, HH:mm",
        template: "D MMM YYYY  HH:mm",
        validate: function(v) {
//                if(v && v.getDate() == 10) return 'Day cant be 10!';
        },
        combodate: {
            minYear: (new Date()).getFullYear(),
            maxYear: 2050,
            yearDescending: false,
            minuteStep: 5
        },
        url: WEB_APP_ROOT+beanType+'/partialUpdate',
        params : function(params) {
            var parsedDate = params['value'].match(/^(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2})$/)
            var ret = {};
            ret['id'] = $(element).attr('data-'+beanType+'-id');
            ret[field] = 'date.struct';
            ret[field+'_day'] = parsedDate[3];
            ret[field+'_month'] = parsedDate[2];
            ret[field+'_year'] = parsedDate[1];
            ret[field+'_hour'] = parsedDate[4];
            ret[field+'_minute'] = parsedDate[5];
            return ret;
        }
    });
}

function switchWard(wardId) {
    $.post(WEB_APP_ROOT+'helpers/switchWard', {
        'ward.id': wardId
    })
        .done(function(user) {
            location.reload();
        })
        .fail(function() {
//            alert("ERROR: could not switch ward");
            console.log("ERROR: could not switch ward");
        })
}

function switchList(listId) {
    $.post(WEB_APP_ROOT+'helpers/switchList', {
        'list.id': listId
    })
        .done(function(user) {
            location.reload();
        })
        .fail(function() {
//            alert("ERROR: could not switch list");
            console.log("ERROR: could not switch list");
        })
}

function userOnCall(onCall) {
    $.post(WEB_APP_ROOT+'helpers/setOnCallStatus', {
        'onCall': onCall
    })
        .done(function(user) {
            location.reload();
        })
        .fail(function() {
//            alert("ERROR: could not update status");
            console.log("ERROR: could not update status");
        })
}

var switchView = function () {
    $(this).siblings().removeClass('active');
    $('.view').hide();

    $(this).addClass('active');
    $('#' + $(this).text().replace(' ', '_')).show();
}
