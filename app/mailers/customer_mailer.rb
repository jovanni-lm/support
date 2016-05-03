class CustomerMailer < ApplicationMailer
  def new_issue_email(issue)
    @issue = issue
    mail(to: @issue.email, subject: 'Support Issue Tracking')
  end

  def issue_reply_email(reply)
    @reply = reply
    @issue = reply.issue
    mail(to: @issue.email, subject: 'Support Issue Tracking')
  end
end
