class LikesMailer < ApplicationMailer

  def notify_post_owner(like)
    @like = like
    @post = like.post
    @owner = @post.user
    mail(to: @owner.email, subject: "You got a new like")
  end
end
