<%@ page import="com.wardbook.Ward; com.wardbook.ReferralList" %>
<g:applyLayout name="bootstrap">
    <head>
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'ward-book-mobile.css')}">
        <style>
        .toto {
            color: white;
            font-size: 1.5em;
            padding: 4px;
            margin: 4px;
        }

        .row-offcanvas {
            /*margin-top: -20px;*/
        }

        .row-offcanvas .list-group-item {
            border-radius: 0px;
        }

        .row-offcanvas-left {
            /*margin-left: 15px;*/
        }

        .row-offcanvas-right {
            /*margin-right: 14px;*/
        }

        .sidebar-offcanvas,
        .col-xs-12 {
            padding: 0px;
        }

        .row-offcanvas-middle.left-open {
            left: 75% !important;
        }

        .row-offcanvas-middle.right-open {
            right: 75% !important;
        }
        </style>
    </head>

    <div class="row-offcanvas row-offcanvas-left">
        <div class="col-xs-9 sidebar-offcanvas" id="sidebar-left" role="navigation">
            <div class="list-group">
                <a href="#" class="list-group-item">
                    <g:select name="a" from="${Ward.list()}" class="form-control" />
                </a>
                <a href="#" class="list-group-item">
                    <g:select name="b" from="${ReferralList.list()}" class="form-control" />
                </a>
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
                    <input />
                </a>
                <a href="#" class="list-group-item">No results</a>
            </div>
        </div>
    </div>

    <div class="row-offcanvas row-offcanvas-middle">
        <div class="navbar navbar-inverse" role="navigation">
            <button type="button" class="btn btn-xs toto" data-toggle="offcanvas-left">
                <span class="glyphicon glyphicon-list"></span>
            </button>

            <div class="pull-right">
                <button type="button" class="btn btn-primary btn-xs toto" data-toggle="offcanvas-right">
                    <span class="glyphicon glyphicon-search" />
                </button>
            </div>
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
            });
        });
    </script>

</g:applyLayout>