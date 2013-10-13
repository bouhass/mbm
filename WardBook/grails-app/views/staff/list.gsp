<%@ page import="com.wardbook.User;" %>
<g:applyLayout name="bootstrap">

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
                    <th>Email</th>
                    <th>Ward</th>
                    <th>Last seen</th>
                    <th>Contact</th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${users}" var="user">
                    <tr>
                        <td>
                            <span class="glyphicon glyphicon-user user-status-${ user.online ? 'online' : 'offline'}"></span>
                        </td>
                        <td>${user.name}</td>
                        <td>${user.username}</td>
                        <td>${user.ward}</td>
                        <td><g:formatDate format="dd-MM-yyyy HH:mm" date="${user.lastSeenAt}"/></td>
                        <td>${user.phoneNumber}</td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>

    </div>

</g:applyLayout>
