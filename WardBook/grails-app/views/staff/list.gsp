<%@ page import="com.wardbook.User;" %>
<g:applyLayout name="bootstrap-navbar">

    <div>

        <div class="col-md-12">
            <g:if test="${flash.message}">
                <bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
            </g:if>

            <table class="table table-striped">
                <thead>
                <tr>
                    <th>Status</th>
                    <th>Name</th>
                    <th>Grade</th>
                    <th>Contact</th>
                    <th>Ward</th>
                    <th>Speciality</th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${users}" var="user">
                    <tr>
                        <td>
                            <span class="glyphicon glyphicon-user user-status-${user.status}"></span>
                            ${user.status.capitalize()}
                        </td>
                        <td>${user.name}</td>
                        <td>${user.grade}</td>
                        <td>${user.phoneNumber}</td>
                        <td>${user.ward?.name}</td>
                        <td>${user.speciality}</td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>

    </div>

</g:applyLayout>
