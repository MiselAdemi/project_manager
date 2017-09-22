module CommentsHelper
  def dynamic_form(commentable)
    if commentable.class == Project
      form_for([commentable, Comment.new], :html => {:multipart => true}) { |f| yield f }
    else
      form_for([commentable.project, commentable, Comment.new], :html => {:multipart => true}) { |f| yield f }
    end
  end
end
