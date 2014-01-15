<div id="comment${comment.id}" class="comment">

	<plugin:isAvailable name="avatar">
		<div class="avatar">
			<avatar:gravatar cssClass="commentAvatar" size="50"
			        email="${comment?.poster.email}" gravatarRating="R"
			        defaultGravatarUrl="${createLinkTo(absolute: true, dir:'/images',file:'grails-icon.png')}"/>
		</div>
	</plugin:isAvailable>

	<div class='commentBody'>
		<g:if test="${noEscape}">
			${comment?.body}
		</g:if>
		<g:else>
        	${comment?.body?.encodeAsHTML()}
		</g:else>
	</div>

	<div class="commentDetails">
		<g:formatDate format="dd MMM yyyy HH:mm" date="${comment.dateCreated}"/>
		by ${comment?.poster}
	</div>

    <hr/>
</div>
