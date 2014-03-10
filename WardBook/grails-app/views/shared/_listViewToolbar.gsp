<%@ page import="com.wardbook.TeamList; com.wardbook.Ward" %>

<style type="text/css" media="print">


nav,
input,
button,
.ward-select,
.hidden-print { /* TODO : this is a hack as bootstrap hidden-print is not working */
    display: none !important;
}
</style>

<div class="row toolbar">

    <div class="col-sm-7 col-md-7 ward-select">
        <div class="btn-group">
            <button type="button" class="btn btn-link btn-lg dropdown-toggle" data-toggle="dropdown">
                <h3>
                    ${
                        request.user.ward ?
                            request.user.ward :
                            request.user.teamList ?
                                request.user.teamList :
                                'All patients' }
                    <span class="caret"></span>
                </h3>
            </button>
            <ul class="dropdown-menu" role="menu" style="width: 480px;">
                <div class="row">
                    <div class="col-md-6">
                        <h4>Wards</h4>
                        <li class="divider"></li>
                        <g:each in="${Ward.list()}" var="ward">
                            <li>
                                <a href='javascript: switchWard(${ward.id})'>${ward}</a>
                            </li>
                        </g:each>
                    </div>
                    <div class="col-md-6">
                        <h4>Lists</h4>
                        <li class="divider"></li>
                        <g:each in="${TeamList.list()}" var="teamList">
                            <li>
                                <a href='javascript: switchList(${teamList.id})'>${teamList}</a>
                            </li>
                        </g:each>
                    </div>
                </div>

                <div class="row col-md-12">
                    <hr/>
                    <a href='javascript: switchWard()'>Show all patients</a>
                </div>
            </ul>
        </div>
    </div>

    <div class="pull-right col-sm-4 col-md-4" style="margin-right: -15px;">
        <div>
            <div class="input-group">
                <input type="text" class="form-control" placeholder="Search" name="search" id="search">

                <div class="input-group-btn">
                    <button class="btn btn-primary">
                        <span class="glyphicon glyphicon-search"></span>
                    </button>
                </div>
            </div>
        </div>
    </div>


        <div class="pull-right">
            <g:if test="${showPrintButton}">
                <g:link action="gridview" params="${[print: true]}" class="btn btn-primary">
                    <span class="glyphicon glyphicon-print"></span>
                </g:link>
            </g:if>

            <g:if test="${showExportButton}">
                <g:link action="csvlist" class="btn btn-primary">
                    <span class="glyphicon glyphicon-export"></span>
                </g:link>
            </g:if>
        </div>

</div>

<script>
    $(window).load(function() {
        $('#search').keyup(filterableSearch);
    });
</script>
