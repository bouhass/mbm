<!-- Sign Off Modal -->
<div class="modal fade hidden-print" id="signoffModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Sign off</h4>
            </div>
            <div class="modal-body">

                <form id="signoffForm">
                    <div class="row">
                        <div class="col-sm-3 col-md-3">
                            Logged in user
                        </div>
                        <div class="col-sm-9 col-md-9">
                            ${request.user}
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-3 col-md-3">
                            Password
                        </div>
                        <div class="col-sm-9 col-md-9">
                            <input type="password" class="form-control" id="password" name="password" placeholder="Password" />
                        </div>
                    </div>

                    %{--<div class="row">--}%
                    %{--<hr/>--}%
                    %{--</div>--}%

                    %{--<div class="row">--}%
                    %{--<div class="col-sm-3 col-md-3">--}%
                    %{--Sign off to--}%
                    %{--</div>--}%
                    %{--<div class="col-sm-9 col-md-9">--}%
                    %{--<% def users = User.list()--}%
                    %{--users.remove(request.user) %>--}%
                    %{--<g:select id="user2" name="user2" class="form-control" from="${users}" noSelection="['':'- Select user -']" optionKey="id" optionValue="name" />--}%
                    %{--</div>--}%
                    %{--</div>--}%

                    %{--<div class="row">--}%
                    %{--<div class="col-sm-3 col-md-3">--}%
                    %{--Password--}%
                    %{--</div>--}%
                    %{--<div class="col-sm-9 col-md-9">--}%
                    %{--<input type="password" class="form-control" id="password2" name="password2" placeholder="Password" />--}%
                    %{--</div>--}%
                    %{--</div>--}%
                </form>

                <div id="signoffSuccessDiv" style="display: none">
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button id="signoff" type="submit" class="btn btn-primary">Sign off</button>
                <g:link id="logout" uri="/logout" class="btn btn-primary" style="display: none">Logout</g:link>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<script>
    $(window).load(function() {
        $('#handover').on('click', function() {
            var $rows = $('.filterable-element');
            if ($(this).hasClass('active')) {
                $rows.show();
                $(this).removeClass('active');
                $('#showSignoffModal').addClass('disabled');
            }
            else {
                $rows.hide().filter(function() {
                    return $(this).find('input[type="checkbox"]').is(':checked');
                }).show();
                $(this).addClass('active');
                $('#showSignoffModal').removeClass('disabled');
            }
        });

        var signOff = function() {
            $.post(WEB_APP_ROOT+'helpers/signOff', $('#signoffModal form').serialize())
                    .done(function() {
                        $('#signoffForm').hide();
                        $('#signoff').hide()
                        var signOffText = 'Thanks. Your sign off has been logged at '+moment(new Date()).format('DD/MM/YYYY HH:mm');
                        $('#signoffSuccessDiv').text(signOffText);
                        $('#signoffSuccessDiv').show();
                        $('#logout').show();
                    })
                    .fail(function() {
                        alert('Could not process the request. Please check your details again.');
                    })
        }

        $('#signoff').on('click', signOff);
        $('#signoffForm').submit(function(ev) {
            ev.preventDefault();
            signOff();
        });
    });
</script>
