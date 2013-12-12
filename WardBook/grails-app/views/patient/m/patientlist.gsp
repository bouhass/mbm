<g:applyLayout name="bootstrap-mobile">
    <div class="list-group">
        <a href="#" class="list-group-item active">
            Cras justo odio
        </a>
        <g:each var="patient" in="${patients}">
            <a href="#" class="list-group-item">${patient}</a>
        </g:each>
    </div>
</g:applyLayout>
