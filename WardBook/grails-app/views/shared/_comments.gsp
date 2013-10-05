<g:set var="comments" value="${commentable.comments}"></g:set>
<div id="comments-${commentable.id}" class="commentable">
    <g:render template="/shared/comment"
              collection="${comments}"
              var="comment"
              model="[noEscape: noEscape]"/>
</div>

<div id="addComment" class="addComment">
    <h4 class="addCommentTitle">
        <a href="#commentEditor" onclick="document.getElementById('addCommentContainer-${commentable.id}').style.display = '';">
            <g:message code="comment.add.title" default="Post a Comment"></g:message>
        </a>
    </h4>

    <div id="addCommentContainer-${commentable.id}" class="addCommentContainer" style="display:none;">
        <div class="addCommentDescription">
            <g:message code="comment.add.description" default=""></g:message>
        </div>
        <a name="commentEditor"></a>
        <g:formRemote name="addCommentForm" url="[controller: 'commentable', action: 'add']" update="comments-${commentable.id}">
            <textarea id="commentBody" name="comment.body" class="form-control" placeholder="Write your comment"></textarea>

            <g:hiddenField name="update" value="comments-${commentable.id}"/>
            <g:hiddenField name="commentLink.commentRef" value="${commentable.id}"/>
            <g:hiddenField name="commentLink.type" value="${commentable.class.name}"/>
            <g:hiddenField name="commentPageURI" value="${request.forwardURI}"></g:hiddenField>

            <button type="submit" class="btn btn-default">Post</button>

        </g:formRemote>
    </div>
</div>