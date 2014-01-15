import grails.util.GrailsNameUtils
import org.grails.comments.Comment
import org.grails.comments.CommentLink

class CommentableController extends org.grails.comments.CommentableController {

    def add = {
        def poster = evaluatePoster()
        def commentLink
        try {
            if (params['comment'] instanceof Map) {
                Comment.withTransaction { status ->
                    def comment = new Comment(params['comment'])
                    comment.posterId = poster.id
                    comment.posterClass = poster.class.name
                    commentLink = new CommentLink(params['commentLink'])
                    commentLink.type = GrailsNameUtils.getPropertyName(commentLink.type)

                    if (!comment.save()) {
                        status.setRollbackOnly()
                    }
                    else {
                        commentLink.comment = comment
                        if (!commentLink.save()) status.setRollbackOnly()
                    }
                }
            }
        }
        catch (Exception e) {
            log.error "Error posting comment: ${e.message}"
        }

        if (request.xhr || params.async) {

            def comments = CommentLink.withCriteria {
                projections {
                    property "comment"
                }
                eq 'type', commentLink.type
                eq 'commentRef', commentLink.commentRef
                cache true
            }

            def noEscape = false
            plugin.isAvailable(name: 'grails-ui') { noEscape = true }
            render template: "/shared/comment",
                    collection: comments,
                    var: "comment",
                    model: [noEscape: noEscape]
        }
        else {
            redirect url: params.commentPageURI
        }
    }
}
