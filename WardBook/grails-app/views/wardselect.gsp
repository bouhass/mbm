<%@ page import="com.wardbook.Ward" %>
<g:applyLayout name="board">

    <div class="col-md-4 col-sm-offset-4 box-middle">
        <div class="row">
            <h4>Select your ward</h4>
        </div>
        <div class="row">
            <div class="form-group">
                <select onchange="switchWard($(this).find('option:selected').attr('value'))" class="form-control">
                    <option value="">All wards</option>
                    <g:each in="${Ward.list()}" var="ward">
                        <option value="${ward.id}" ${ward.id == request.user.ward?.id ? 'selected' : ''}>${ward}</option>
                    </g:each>
                </select>
            </div>
        </div>
        <div class="row">
            <g:link controller="board" class="btn btn-default">View patients ></g:link>
        </div>
    </div>

</g:applyLayout>