<%@ page import="com.wardbook.Contact; com.wardbook.User;" %>
<g:applyLayout name="bootstrap-navbar">

    <div class="col-sm-12 col-md-12">
        <g:if test="${flash.message}">
            <bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
        </g:if>

        <h4>Staff</h4>

        <table class="table table-striped">
            <thead>
            <tr>
                <th>Status</th>
                <th>Name</th>
                <th>Grade</th>
                <th>Phone</th>
                <th>Ward</th>
                <th>Speciality</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${User.list()}" var="user">
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

    <div class="col-sm-12 col-md-12">
        <h4>Contacts</h4>

        <table class="table table-striped">
            <thead>
            <tr>
                <th>Name</th>
                <th>Phone</th>
                <th>Location</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${Contact.list()}" var="contact">
                <tr>
                    <td>
                        <a data-id="${contact.id}" data-value="${contact.name}" class="contact-name">${contact.name}</a>
                    </td>
                    <td>
                        <a data-id="${contact.id}" data-value="${contact.phoneNumber}" class="contact-phoneNumber">${contact.phoneNumber}</a>
                    </td>
                    <td>
                        <a data-id="${contact.id}" data-value="${contact.location}" class="contact-location">${contact.location}</a>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>

        <hr/>

        <g:link controller="contact" action="add" class="btn btn-primary pull-right">Add contact</g:link>
    </div>

    <script>
        $(window).load(function() {
            $('.contact-name').each(function() {
                updateEntityField(this, 'contact', 'name', 'text')
            });

            $('.contact-phoneNumber').each(function() {
                updateEntityField(this, 'contact', 'phoneNumber', 'text')
            });

            $('.contact-location').each(function() {
                updateEntityField(this, 'contact', 'location', 'text')
            });
        });
    </script>

</g:applyLayout>
