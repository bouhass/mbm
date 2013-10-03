<%@ page import="com.wardbook.User; com.wardbook.Patient; com.wardbook.Ward" %>
<g:applyLayout name="patient">

    <div>

        <div class="col-md-7">
            <g:if test="${flash.message}">
                <bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
            </g:if>

            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Location</th>
                        <th>Name</th>
                        <th>Consultant</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                <g:each in="${patients}" var="entry">
                    <tr>
                        <td colspan="5"><h4>${entry.key}</h4></td>
                    </tr>
                    <g:each in="${entry.value}" var="patient">
                        <tr>
                            <td>${patient.location}</td>
                            <td>${patient}</td>
                            <td>${patient.consultant}</td>
                            <td>${patient.status}</td>
                            <td>${patient.tasks.size()} jobs</td>
                        </tr>
                    </g:each>
                </g:each>
                </tbody>
            </table>

            %{--<div class="pagination">--}%
                %{--<bootstrap:paginate total="${patientInstanceTotal}"/>--}%
            %{--</div>--}%
        </div>

        <div class="col-md-5">
            <div class="panel panel-info">
                <div class="panel-heading">
                    Filter patients to add to list
                </div>
                <div class="panel-body">
                    <form class="form-horizontal" role="form">
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Ward</label>
                            <div class="col-lg-9">
                                <select name="ward" class="form-control">
                                    <option value="" ${params.ward == '' ? 'selected' : ''}>All - No filter</option>
                                    <g:each in="${Ward.list()}" var="ward">
                                        <option value="${ward.id}" ${params.ward == ward.id.toString() ? 'selected' : ''}>${ward}</option>
                                    </g:each>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Consultant</label>
                            <div class="col-lg-9">
                                <select name="consultant" class="form-control">
                                    <option value="" ${params.consultant == '' ? 'selected' : ''}>All - No filter</option>
                                    <g:each in="${User.consultants()}" var="consultant">
                                        <option value="${consultant.name}" ${params.consultant == consultant.name ? 'selected' : ''}>${consultant.name}</option>
                                    </g:each>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Status</label>
                            <div class="col-lg-9">
                                <select name="status" class="form-control">
                                    <option value="" ${params.status == '' ? 'selected' : ''}>All - No filter</option>
                                    <g:each in="${Patient.constraints.status.inList}" var="status">
                                        <option value="${status}" ${params.status == status ? 'selected' : ''}>${status}</option>
                                    </g:each>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-offset-3 col-lg-9">
                                <button type="submit" class="btn btn-default">Filter</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </div>

</g:applyLayout>
