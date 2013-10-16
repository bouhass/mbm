<g:applyLayout name="board">

    <div class="row text-center">

        <div class="col-md-4">
            <h4>Current ward activity</h4>
            <canvas id="tasksTimeChart" width="350" height="250"></canvas>
        </div>

        <div class="col-md-4">
            <h4>Workload per ward</h4>
            <canvas id="workloadChart" width="350" height="250"></canvas>
        </div>

        <div class="col-md-4">
            <h4>Out of hours tasks</h4>
            <canvas id="tasksTypeChart" width="350" height="250"></canvas>
        </div>

    </div>

    <div class="row text-center">
        <div class="col-md-4">
            <h4>Number of MRI booked</h4>
            <canvas id="mriChart" width="350" height="250"></canvas>
        </div>

        <div class="col-md-4">
            %{--<h4>Wards</h4>--}%
            <div class="row"><span class="label label-default">Lind ward</span></div>
            <div class="row"><span class="label label-danger">Paul wood ward</span></div>
            <div class="row"><span class="label label-info">Princess Alexandra ward</span></div>
            <div class="row"><span class="label label-primary">Rose ward</span></div>
            <div class="row"><span class="label label-success">Victoria ward</span></div>
            <div class="row"><span class="label label-warning">York ward</span></div>
        </div>

        <div class="col-md-4">
            <h4>Length of stay</h4>
            <canvas id="lengthOfStay" width="350" height="250"></canvas>
        </div>
    </div>

    <script src="${resource(dir: 'js', file: 'Chart.min.js')}"></script>

    <script>
        var tasksTimeData = {
            labels : ["7am", "9am", "5pm", "9pm", "1am", "5am"],
            datasets : [
                {
                    fillColor : "rgba(151,187,205,0.5)",
                    strokeColor : "rgba(151,187,205,1)",
                    pointColor : "rgba(151,187,205,1)",
                    pointStrokeColor : "#fff",
                    data : [23, 96, 28, 48, 27, 25]
                }
            ]
        }

        var tasksTypeData = {
            labels : ["Wafarin", "Cannulate", "Rewrite chart", "Fluids", "Review X-Ray", "Take bloods"],
            datasets : [
                {
                    fillColor : "rgba(151,187,205,0.5)",
                    strokeColor : "rgba(151,187,205,1)",
                    data : [4, 3, 6, 3, 4, 3]
                }
            ]
        }

        var mriData = {
            labels : ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
            datasets : [
                {
                    fillColor : "rgba(151,187,205,0.5)",
                    strokeColor : "rgba(151,187,205,1)",
                    pointColor : "rgba(151,187,205,1)",
                    pointStrokeColor : "#fff",
                    data : [10, 4, 2, 3, 7, 0, 1]
                }
            ]
        }

        var workloadData = [
            {
                value: 30,
                color:"#999"
            },
            {
                value : 50,
                color : "#d9534f"
            },
            {
                value : 100,
                color : "#5bc0de"
            },
            {
                value : 40,
                color : "#428bca"
            },
            {
                value : 110,
                color : "#5cb85c"
            },
            {
                value : 10,
                color : "#f0ad4e"
            }
        ]

        var lengthOfStayData = {
            labels : ["April", "May", "June", "July", "August", "September", "October"],
            datasets : [
                {
                    fillColor : "rgba(151,187,205,0.5)",
                    strokeColor : "rgba(151,187,205,1)",
                    pointColor : "rgba(151,187,205,1)",
                    pointStrokeColor : "#fff",
                    data : [5, 4.2, 4.7, 4, 5, 5.2, 3.7]
                }
            ]
        }

        $(window).load(function() {
            new Chart($("#tasksTimeChart").get(0).getContext("2d")).Line(tasksTimeData, {});

            new Chart($("#tasksTypeChart").get(0).getContext("2d")).Bar(tasksTypeData, {
                scaleOverride : true,
                scaleSteps : 7,
                scaleStepWidth : 1,
                scaleStartValue : 0
            });

            new Chart($("#mriChart").get(0).getContext("2d")).Line(mriData, {
                scaleOverride : true,
                scaleSteps : 10,
                scaleStepWidth : 1,
                scaleStartValue : 0
            });

            new Chart($("#workloadChart").get(0).getContext("2d")).Doughnut(workloadData, {});

            new Chart($("#lengthOfStay").get(0).getContext("2d")).Line(lengthOfStayData, {
                scaleOverride : true,
                scaleSteps : 6,
                scaleStepWidth : 1,
                scaleStartValue : 0
            });
        });
    </script>

</g:applyLayout>
