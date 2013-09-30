<ul>
    <g:each in="${patient.records}" var="record">
        <li>${record}</li>
    </g:each>
</ul>
<ul>
    <g:each in="${patient.tasks}" var="task">
        <li>${task}</li>
    </g:each>
</ul>