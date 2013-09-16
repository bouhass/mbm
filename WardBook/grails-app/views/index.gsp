<!doctype html>
<html>
	<head>
		<meta name="layout" content="bootstrap"/>
		<title><g:meta name="app.name"/></title>
	</head>

	<body>
		<div class="row">
			<aside id="application-status" class="span3">
				<div class="well sidebar-nav">
					<h5>Another nav menu?</h5>
					<ul>
						<li>blah</li>
						<li>blih</li>
						<li>bloh</li>
					</ul>
					<h5>Or update feeds?</h5>
					<ul>
						<li>Some good news</li>
						<li>Some bad</li>
						<li>Feed</li>
						<li>Feed</li>
						<li>Feed</li>
						<li>Feed</li>
						<li>Feed</li>
						<li>Feed</li>
						<li>Feed</li>
						<li>Feed</li>
					</ul>
				</div>
			</aside>

			<section id="main" class="span9">

				<div class="hero-unit">
					<h1>Welcome Doc</h1>
					<p>Some welcome text ...</p>
				</div>
					
				<div class="row-fluid">
					
					<div class="span4">
						<h2>Patients</h2>
						<p>Latest admissions:</p>
						<ul class="nav nav-list">
							<%--
							<g:each var="p" in="${Patient.list()}">
							 --%>
								<li><g:link controller="patient">Joseph Love</g:link></li>
								<li><g:link controller="patient">Josh Knight</g:link></li>
								<li><g:link controller="patient">Anish Lee</g:link></li>
								<li>...</li>
							<%--
							</g:each>
							 --%>
						</ul>
					</div>

					<div class="span4">
						<h2>Tasks</h2>
						<p>Joseph Love</p>
						<pre>Blood tests</pre>
						<p>Anish Lee</p>
						<pre>X-Rays</pre>
					</div>
					
					<div class="span4">
						<h2>News</h2>
						<p>Some comment on a patient</p>
						<p>Another comment ...</p>
					</div>

				</div>

			</section>
		</div>
		
	</body>
</html>
