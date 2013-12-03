<%@ page import="com.wardbook.ReferralList; com.wardbook.Ward" %>
<g:applyLayout name="board">

    <div class="col-sm-6 col-md-4 col-sm-offset-3 col-md-offset-4 box-middle">
        <div class="row">
            <h4>Select a ward</h4>
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
            <h4>Or select a list</h4>
        </div>
        <div class="row">
            <div class="form-group">
                <select onchange="switchList($(this).find('option:selected').attr('value'))" class="form-control">
                    <option value="">All lists</option>
                    <g:each in="${ReferralList.list()}" var="referralList">
                        <option value="${referralList.id}" ${referralList.id == request.user.referralList?.id ? 'selected' : ''}>${referralList}</option>
                    </g:each>
                </select>
            </div>
        </div>

        <div class="row">
            <g:link controller="patient" class="btn btn-default">View patients ></g:link>
        </div>
    </div>

</g:applyLayout>