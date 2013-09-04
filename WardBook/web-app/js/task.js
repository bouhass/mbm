(function ($) {
    "use strict";
    
    var Task = function (options) {
        this.init('task', options, Task.defaults);
    };

    //inherit from Abstract input
    $.fn.editableutils.inherit(Task, $.fn.editabletypes.abstractinput);

    $.extend(Task.prototype, {

        render: function() {
           this.$input = this.$tpl.find('input');
           this.$select = this.$tpl.find('select');
           this.$textarea = this.$tpl.find('textarea');
        },
        
        /** Default value to be shown **/
        value2html: function(value, element) {
            if(!value) {
                $(element).empty();
                return; 
            }
            $(element).siblings().children('img').attr('src', taskStatusToImage(value.status));
            $(element).html(value.name);
        },
        
        /**
        Gets value from element's html
        
        @method html2value(html) 
        **/        
        html2value: function(html) {        
          /*
            you may write parsing method to get value by element's html
            e.g. "Moscow, st. Lenina, bld. 15" => {city: "Moscow", street: "Lenina", building: "15"}
            but for complex structures it's not recommended.
            Better set value directly via javascript, e.g. 
            editable({
                value: {
                    city: "Moscow", 
                    street: "Lenina", 
                    building: "15"
                }
            });
          */ 
          return '';  
        },
      
       /**
        Converts value to string. 
        It is used in internal comparing (not for sending to server).
        
        @method value2str(value)  
       **/
       value2str: function(value) {
           var str = '';
           if(value) {
               for(var k in value) {
                   str = str + k + ':' + value[k] + ';';  
               }
           }
           return str;
       }, 
       
       /*
        Converts string to value. Used for reading value from 'data-value' attribute.
        
        @method str2value(str)  
       */
       str2value: function(str) {
           /*
           this is mainly for parsing value defined in data-value attribute. 
           If you will always set value by javascript, no need to overwrite it
           */
           return str;
       },                
       
       /**
        Sets value of input.
        
        @method value2input(value) 
        @param {mixed} value
       **/         
       value2input: function(value) {
           if(!value) {
             return;
           }
           this.$input.filter('[name="name"]').val(value.name);
           this.$select.filter('[name="status"]').val(value.status);
           this.$select.filter('[name="priority"]').val(value.priority);
           this.$textarea.filter('[name="comment"]').val(value.comment);
       },
       
       /**
        Returns value of input.
        
        @method input2value() 
       **/          
       input2value: function() { 
           return {
              name: this.$input.filter('[name="name"]').val(), 
              status: this.$select.filter('[name="status"]').val(),
              priority: this.$select.filter('[name="priority"]').val(),
              comment: this.$textarea.filter('[name="comment"]').val()
           };
       },        
       
        /**
        Activates input: sets focus on the first field.
        
        @method activate() 
       **/        
       activate: function() {
            this.$input.filter('[name="name"]').focus();
       },  
       
       /**
        Attaches handler to submit form in case of 'showbuttons=false' mode
        
        @method autosubmit() 
       **/       
       autosubmit: function() {
           this.$input.keydown(function (e) {
                if (e.which === 13) {
                    $(this).closest('form').submit();
                }
           });
       }       
    });
    
    Task.defaults = $.extend({}, $.fn.editabletypes.abstractinput.defaults, {
        tpl:
            '<div class="editable-task">' +
                '<label>' +
                    '<span>Name: </span>' +
                    '<input type="text" name="name" class="input-medium">' +
                '</label>' +
            '</div>'+
            '<div class="editable-task">' +
                '<label>' +
                    '<span>Status: </span>' +
                    '<select name="status" class="input-medium">'+
                        '<option value="PENDING">PENDING</option>'+
                        '<option value="STARTED">STARTED</option>'+
                        '<option value="COMPLETED">COMPLETED</option>'+
                    '</select>' +
                '</label>' +
            '</div>' +
            '<div class="editable-task">' +
                '<label>' +
                    '<span>Priority: </span>' +
                    '<select name="priority" class="input-medium">'+
                        '<option value="NORMAL">NORMAL</option>'+
                        '<option value="HIGH">HIGH</option>'+
                        '<option value="URGENT">URGENT</option>'+
                    '</select>' +
                '</label>' +
            '</div>' +
            '<div class="editable-task">' +
                '<label>' +
                    '<span>Comments: </span>' +
                    '<br/>' +
                    '<textarea name="comment" class="input-large"/>' +
                '</label>' +
            '</div>'+'',
             
        inputclass: ''
    });

    $.fn.editabletypes.task = Task;

}(window.jQuery));