<%@ page import="com.wardbook.Ward; com.wardbook.ReferralList" %>
<div class="toolbar">
    <div class="col-sm-12 col-md-12">
        <div class="pull-right col-sm-2 col-md-3">
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
            <g:select id="wards" name="wards" from="${Ward.list()}" value="${request.user.ward?.id}"
                      noSelection="${ request.user.ward ? ['':'- Display all -'] : ['':'- Select ward -']}"
                      optionKey="id" optionValue="name"/>
            <g:select id="referralLists" name="referralLists" from="${ReferralList.list()}" value="${request.user.referralList?.id}"
                      noSelection="${ request.user.referralList ? ['':'- Display all -'] : ['':'- Select list -']}"
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

        $('#wards').on('change', function(e) {
            switchWard(this.value);
        });

        $('#referralLists').on('change', function(e) {
            switchList(this.value);
        });
    });
</script>
