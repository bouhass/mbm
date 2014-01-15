<g:set var="comments" value="${commentable.comments}"></g:set>

<h4>Comments</h4>

<hr/>

<div id="comments-${commentable.id}" class="commentable">
    <g:render template="/shared/comment"
              collection="${comments}"
              var="comment"
              model="[noEscape: noEscape]"/>
</div>

<div id="addComment" class="addComment">
    <div id="addCommentContainer-${commentable.id}" class="addCommentContainer">
        <div class="addCommentDescription">
            <g:message code="comment.add.description" default=""></g:message>
        </div>
        <a name="commentEditor"></a>
        <g:formRemote name="addCommentForm" url="[controller: 'commentable', action: 'add']"
                      update="comments-${commentable.id}" after="jQuery('#commentBody').val('')">

            <textarea id="commentBody" name="comment.body" class="form-control"
                      placeholder="Write your comment"></textarea>

            <g:hiddenField name="update" value="comments-${commentable.id}"/>
            <g:hiddenField name="commentLink.commentRef" value="${commentable.id}"/>
            <g:hiddenField name="commentLink.type" value="${commentable.class.name}"/>
            <g:hiddenField name="commentPageURI" value="${request.forwardURI}"></g:hiddenField>

            <br/>

            <button type="submit" class="btn btn-primary form-control">Post</button>

        </g:formRemote>
    </div>
</div>