<g:applyLayout name="bootstrap">
<h1>Patient list</h1>
<table>
<g:each var="p" in="${patients}">
    <tr>
        <td>${p}</td>
    </tr>
</g:each>
</table>
</g:applyLayout>