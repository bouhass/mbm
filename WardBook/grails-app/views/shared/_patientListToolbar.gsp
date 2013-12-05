<%@ page import="com.wardbook.User; com.wardbook.Ward; com.wardbook.ReferralList" %>

<div class="row hidden-print">
    <div class="col-sm-2 col-md-2">
        <g:select id="wards" name="wards" class="form-control"
                  from="${Ward.list()}" value="${request.user.ward?.id}"
                  noSelection="${ request.user.ward ? ['':'- Display all -'] : ['':'- Select ward -']}"
                  optionKey="id" optionValue="name"/>
    </div>

    <div class="col-sm-2 col-md-2">
        <g:select id="referralLists" name="referralLists" class="form-control"
                  from="${ReferralList.list()}" value="${request.user.referralList?.id}"
                  noSelection="${ request.user.referralList ? ['':'- Display all -'] : ['':'- Select list -']}"
                  optionKey="id" optionValue="name"/>
    </div>

    <div class="pull-right col-sm-3 col-md-3">
        <div class="input-group">
            <input type="text" class="form-control" placeholder="Search" name="search" id="search">

            <div class="input-group-btn">
                <button class="btn btn-primary">
                    <span class="glyphicon glyphicon-search"></span>
                </button>
            </div>
        </div>
    </div>

    <div class="pull-right" style="margin-bottom: 8px">
        <g:link controller="patient" action="add" class="btn btn-primary">
            Add patient
        </g:link>
        %{--<a data-toggle="modal" href="#customizeView" class="btn btn-default">--}%
        %{--Edit view--}%
        %{--</a>--}%
        <a class="btn btn-primary" onclick="window.print()">
            <span class="glyphicon glyphicon-print"></span>
        </a>
        <a id="handover" class="btn btn-primary">
            Handover
        </a>
        <a id="showSignoffModal" class="btn btn-danger disabled" data-toggle="modal" data-target="#signoffModal">
            Sign off
        </a>

    </div>
</div>

<!-- Sign Off Modal -->
<div class="modal fade" id="signoffModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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

                    <div class="row">
                        <hr/>
                    </div>

                    <div class="row">
                        <div class="col-sm-3 col-md-3">
                            Sign off to
                        </div>
                        <div class="col-sm-9 col-md-9">
                            <% def users = User.list()
                            users.remove(request.user) %>
                            <g:select id="user2" name="user2" class="form-control" from="${users}" noSelection="['':'- Select user -']" optionKey="id" optionValue="name" />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-3 col-md-3">
                            Password
                        </div>
                        <div class="col-sm-9 col-md-9">
                            <input type="password" class="form-control" id="password2" name="password2" placeholder="Password" />
                        </div>
                    </div>
                </form>

                <div id="signoffSuccessDiv" style="display: none">
                    Successfully signed off
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button id="signoff" type="button" class="btn btn-primary">Sign off</button>
                <g:link id="logout" uri="/logout" class="btn btn-primary" style="display: none">Logout</g:link>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script>
    $(window).load(function() {
        $('#search').keyup(patientTableSearch);

        $('#handover').on('click', function() {
            var $rows = $('#patients-table > tbody > tr');
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

        $('#signoff').on('click', function() {
            $.post(WEB_APP_ROOT+'helpers/signOff', $('#signoffModal form').serialize())
                    .done(function(task) {
                        $('#signoffForm').hide();
                        $('#signoff').hide()
                        $('#signoffSuccessDiv').show();
                        $('#logout').show();
                    })
                    .fail(function() {
                        alert('Could not process the request. Please check your details again.');
                    })
        });

        $('#wards').on('change', function(e) {
            switchWard(this.value);
        });

        $('#referralLists').on('change', function(e) {
            switchList(this.value);
        });
    });
</script>
