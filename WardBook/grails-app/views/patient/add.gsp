<%@ page import="com.wardbook.Patient" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="bootstrap-popover">
		<g:set var="entityName" value="${message(code: 'patient.label', default: 'Patient')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<%-- 
		<div class="span3">
			<div class="well">
				<ul class="nav nav-list">
					<li class="nav-header">${entityName}</li>
					<li>
						<g:link class="list" action="overview">
							<span class="glyphicon glyphicon-list"></span>
							<g:message code="default.list.label" args="[entityName]" />
						</g:link>
					</li>
					<li class="active">
						<g:link class="create" action="add">
							<span class="glyphicon glyphicon-plus icon-white"></span>
							<g:message code="default.create.label" args="[entityName]" />
						</g:link>
					</li>
				</ul>
			</div>
		</div>
		 --%>
			
		<div>

			<div class="page-header">
				<h1><g:message code="default.create.label" args="[entityName]" /></h1>
			</div>

			<g:if test="${flash.message}">
			<bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
			</g:if>

			<g:hasErrors bean="${patientInstance}">
			<bootstrap:alert class="alert-error">
			<ul>
				<g:eachError bean="${patientInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</bootstrap:alert>
			</g:hasErrors>

			<fieldset>
				<g:form class="form-horizontal" action="create" >
					<fieldset>
						<f:all bean="patientInstance"/>
						<div class="form-actions">
							<button type="submit" class="btn btn-primary">
                                <span class="glyphicon glyphicon-ok icon-white"></span>
								<g:message code="default.button.create.label" default="Create" />
							</button>
						</div>
					</fieldset>
				</g:form>
			</fieldset>
			
		</div>

	</body>
</html>
