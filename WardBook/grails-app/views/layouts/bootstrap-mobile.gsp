<%@ page import="com.wardbook.Ward; com.wardbook.ReferralList" %>
<g:applyLayout name="bootstrap">
    <head>
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'ward-book-mobile.css')}">
    </head>

    <div class="row-offcanvas row-offcanvas-left">
        <div class="col-xs-9 sidebar-offcanvas" id="sidebar-left" role="navigation">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title text-center">WardBook</h3>
                </div>

                <div class="panel-heading s-header">
                    <h5 class="panel-title s-title">Select Ward</h5>
                </div>

                <div class="panel-body">
                    <a href="javascript:;">
                        <g:select id="wards" name="wards" class="form-control"
                                  from="${Ward.list()}" value="${request.user.ward?.id}"
                                  noSelection="${request.user.ward ? ['': '- Display all -'] : ['': '- All Ward -']}"
                                  optionKey="id" optionValue="name"/>
                    </a>
                </div>

                <div class="panel-heading s-header">
                    <h5 class="panel-title s-title">Select List</h5>
                </div>

                <div class="panel-body">
                    <a href="javascript:;">
                        <g:select id="referralLists" name="referralLists" class="form-control"
                                  from="${ReferralList.list()}" value="${request.user.referralList?.id}"
                                  noSelection="${request.user.referralList ? ['': '- Display all -'] : ['': '- Default List -']}"
                                  optionKey="id" optionValue="name"/>
                    </a>
                </div>

                <g:link uri="/logout" class="btn btn-default list-group-item">
                    <span class="glyphicon glyphicon-log-out"></span> Logout
                </g:link>
            </div>
        </div><!--/span-->
    </div>

    <div class="row-offcanvas row-offcanvas-right">
        <div class="col-xs-9 sidebar-offcanvas" id="sidebar-right" role="navigation">
            <div class="list-group">
                <a href="#" class="list-group-item active">
                    <input id="search" class="form-control" placeholder="Type a patient name"/>
                </a>
                <div id="search-results">
                </div>
            </div>
        </div>
    </div>

    <div class="row-offcanvas row-offcanvas-middle">
        <div class="navbar navbar-inverse" role="navigation">
            <div class="pull-left">
                <a class="btn-nav menu-button" data-toggle="offcanvas-left">
                    <span class="glyphicon glyphicon-align-justify"></span>
                </a>
            </div>

            <div class="pull-right">
                <a class="btn-nav menu-button" data-toggle="offcanvas-right">
                    <span class="glyphicon glyphicon-search" />
                </a>
            </div>

            <g:if test="${navTitle}">
                <h4>${navTitle}</h4>
            </g:if>

        </div><!-- /.navbar -->

        <div class="col-xs-12">

            <g:layoutBody/>

        </div><!--/span-->
    </div>

    <script>
        $(document).ready(function() {
            $('[data-toggle=offcanvas-left]').click(function() {
                $('.row-offcanvas-left').toggleClass('active');
                $('.row-offcanvas-middle').toggleClass('left-open');
            });

            $('[data-toggle=offcanvas-right]').click(function() {
                $('.row-offcanvas-right').toggleClass('active');
                $('.row-offcanvas-middle').toggleClass('right-open');
                if ($('.row-offcanvas-right').hasClass('active')) {
                    $('#search').focus();
                }
                else {
                    $('#search').blur();
                }
            });

            $('#wards').on('change', function(e) {
                switchWard(this.value);
            });

            $('#referralLists').on('change', function(e) {
                switchList(this.value);
            });

            $('#search').keyup(function() {
                $('#search-results').empty();
                var query = $(this).val();
                if (query.length > 2) {
                    $('#search-results').append('<a href="#" class="list-group-item"><img src="'+WEB_APP_ROOT+'images/spinner.gif" /></a>');
                    $.get(WEB_APP_ROOT+'patient/search?q='+query)
                            .always(function() {
                                $('#search-results').empty();
                            })
                            .done(function(patients) {
                                if ($(patients).size() > 0) {
                                    $(patients).each(function(i, patient) {
                                        $('#search-results').append(
                                                '<a href="'+WEB_APP_ROOT+'patient/profile/'+patient.id+'" class="list-group-item">'+patient.firstName+' '+patient.lastName+'</a>'
                                        );
                                    });
                                }
                                else {
                                    $('#search-results').append('<a href="#" class="list-group-item">No results found</a>');
                                }
                            })
                            .fail(function() {
                                $('#search-results').append('<a href="#" class="list-group-item">Error, please retry</a>');
                            })
                }
            });
        });
    </script>

</g:applyLayout>