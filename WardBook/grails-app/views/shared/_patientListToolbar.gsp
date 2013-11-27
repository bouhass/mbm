<%@ page import="com.wardbook.ReferralList" %>
<div class="toolbar">
    <div class="col-sm-3 col-md-3">
    </div>

    <div class="col-sm-9 col-md-9">
        <div class="pull-right col-sm-4 col-md-4">
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
            <g:select id="referralLists" name="referralLists" from="${ReferralList.list()}" value="${params.referralList}"
                      noSelection="${ params.referralList ? ['':'- Display all -'] : ['':'- Select list -']}"
                      optionKey="id" optionValue="name"/>
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

        </div>
    </div>
</div>

<script>
    $(window).load(function() {
        $('#search').keyup(patientTableSearch);

        $('#referralLists').on('change', function(e) {
            if (this.value) {
                window.location.search = '?referralList=' + this.value;
            }
            else {
                window.location.search = '';
            }
        });
    });
</script>
