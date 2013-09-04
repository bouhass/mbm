
<%@ page import="com.wardbook.Patient" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="bootstrap">
		<g:set var="entityName" value="${message(code: 'patient.label', default: 'Patient')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="row-fluid">
			
			<div class="span6">
			
			<div class="span11">
				<div class="well">
					<ul class="nav nav-list">
						<li class="nav-header">${entityName}</li>
						<li class="active">
							<g:link class="list" action="overview">
								<i class="icon-list icon-white"></i>
								<g:message code="default.list.label" args="[entityName]" />
							</g:link>
						</li>
						<li>
                            <a href="create" class="create">
                                <i class="icon-plus"></i>
                                <g:message code="default.create.label" args="[entityName]" />
                            </a>

							%{--<a href="#" class="create" id="openBtn">--}%
								%{--<i class="icon-plus"></i>--}%
								%{--<g:message code="default.create.label" args="[entityName]" />--}%
							%{--</a>--}%

							<%-- 
							<g:link id="openBtn" class="create" action="add" data-toggle="modal" data-remote="add" data-target="#addPatientModal">
								<i class="icon-plus"></i>
								<g:message code="default.create.label" args="[entityName]" />
							</g:link>
							 --%>
						</li>
					</ul>
				</div>
			</div>

			<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" style="width: 1000px; left: 500px; height: 600px;">
				<!-- 
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">×</button>
					<h3>Title</h3>
				</div>
				 -->
				 <!-- 
				<div class="modal-body" style="height: 90%">
				 -->
					<button type="button" class="close" data-dismiss="modal">×</button>
					<iframe src="" frameborder="0" height="90%" width="99.6%"></iframe>
				<!--
				</div> 
				<div class="modal-footer">
					<button class="btn" data-dismiss="modal">OK</button>
				</div>
				 -->
			</div>

			<div>
				
				<div class="page-header">
					<h1><g:message code="default.list.label" args="[entityName]" /></h1>
				</div>

				<g:if test="${flash.message}">
				<bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
				</g:if>
				
				<table class="table table-striped">
					<thead>
						<tr>
						
							<g:sortableColumn property="firstName" title="${message(code: 'patient.firstName.label', default: 'First Name')}" />
						
							<g:sortableColumn property="lastName" title="${message(code: 'patient.lastName.label', default: 'Last Name')}" />
						
							<g:sortableColumn property="dateOfBirth" title="${message(code: 'patient.dateOfBirth.label', default: 'Date Of Birth')}" />
						
							<g:sortableColumn property="status" title="${message(code: 'patient.status.label', default: 'Status')}" />
						
							<th></th>
						</tr>
					</thead>
					<tbody>
					<g:each in="${patientInstanceList}" var="patientInstance">
						<tr>
						
							<td>${fieldValue(bean: patientInstance, field: "firstName")}</td>
						
							<td>${fieldValue(bean: patientInstance, field: "lastName")}</td>
						
							<td>${fieldValue(bean: patientInstance, field: "dateOfBirth")}</td>
						
							<td>${fieldValue(bean: patientInstance, field: "status")}</td>
						
							<td class="link">
								<a data-poload="${createLink(action: 'summary', id: patientInstance.id)}" class="btn btn-small popup-marker">Show &raquo;</a>
							</td>
							
						</tr>
					</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<bootstrap:paginate total="${patientInstanceTotal}" />
				</div>
			</div>

			</div>
			
		</div>

	<script>

		$(document).ready(function() {
			$('.popup-marker').on("click", function() {
				var element = $(this);
				$.get($(this).attr('data-poload'), function(d) {
					$(".popover").hide();
					element.popover({
						content : d,
						html : true,
						trigger : 'manual'
					}).popover("show");
				});
			});

			var frameSrc = WEB_APP_ROOT+'patient/add';

			$('#openBtn').click(function(){
			    $('#myModal').on('show', function () {

			        $('iframe').attr("src",frameSrc);
			      
				});
			    $('#myModal').modal({show:true})
			});

		});
	</script>

</body>
</html>
