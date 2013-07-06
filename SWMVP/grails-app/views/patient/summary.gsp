
<%@ page import="com.smartward.Patient" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="bootstrap-popover">
		<g:set var="entityName" value="${message(code: 'patient.label', default: 'Patient')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="row-fluid">
			<%--
			<div class="span3">
				<div class="well">
					<ul class="nav nav-list">
						<li class="nav-header">${entityName}</li>
						<li>
							<g:link class="list" action="overview">
								<i class="icon-list"></i>
								<g:message code="default.list.label" args="[entityName]" />
							</g:link>
						</li>
						<li>
							<g:link class="create" action="create">
								<i class="icon-plus"></i>
								<g:message code="default.create.label" args="[entityName]" />
							</g:link>
						</li>
					</ul>
				</div>
			</div>
			 --%>
			
			<div>

				<div class="page-header">
					<h1>${patientInstance}</h1>
				</div>

				<g:if test="${flash.message}">
				<bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
				</g:if>

				<dl>
				
					<g:if test="${patientInstance?.gender}">
						<dt><g:message code="patient.gender.label" default="Gender" /></dt>
						
							<dd><g:fieldValue bean="${patientInstance}" field="gender"/></dd>
						
					</g:if>
				
					<g:if test="${patientInstance?.status}">
						<dt><g:message code="patient.status.label" default="Status" /></dt>
						
							<dd><g:fieldValue bean="${patientInstance}" field="status"/></dd>
						
					</g:if>
				
					<g:if test="${patientInstance?.location}">
						<dt><g:message code="patient.location.label" default="Location" /></dt>
						
							<dd><g:fieldValue bean="${patientInstance}" field="location"/></dd>
						
					</g:if>
				
					<g:if test="${patientInstance?.consultant}">
						<dt><g:message code="patient.consultant.label" default="Consultant" /></dt>
						
							<dd><g:fieldValue bean="${patientInstance}" field="consultant"/></dd>
						
					</g:if>
				
					<g:if test="${patientInstance?.dateOfBirth}">
						<dt><g:message code="patient.dateOfBirth.label" default="Date Of Birth" /></dt>
						
							<dd><g:formatDate date="${patientInstance?.dateOfBirth}" /></dd>
						
					</g:if>
				
					<g:if test="${patientInstance?.records}">
						<dt><g:message code="patient.records.label" default="Records" /></dt>
						
							<g:each in="${patientInstance.records}" var="r">
							<dd><g:link controller="record" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></dd>
							</g:each>
						
					</g:if>
				
					<g:if test="${patientInstance?.tasks}">
						<dt><g:message code="patient.tasks.label" default="Tasks" /></dt>
						
							<g:each in="${patientInstance.tasks}" var="t">
							<dd><g:link controller="task" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></dd>
							</g:each>
						
					</g:if>
				
				</dl>

				<g:form>
					<g:hiddenField name="id" value="${patientInstance?.id}" />
					<div class="form-actions">
						<g:link class="btn btn-info" action="show" id="${patientInstance?.id}">
							<i class="icon-user"></i>
							<g:message code="patient.show.label" default="Full profile" />
						</g:link>
						<g:link class="btn btn-warning" action="edit" id="${patientInstance?.id}">
							<i class="icon-pencil"></i>
							<g:message code="default.button.edit.label" default="Edit" />
						</g:link>
						<button class="btn btn-danger" type="submit" name="_action_delete">
							<i class="icon-trash icon-white"></i>
							<g:message code="default.button.delete.label" default="Delete" />
						</button>
					</div>
				</g:form>

			</div>

		</div>
	</body>
</html>
