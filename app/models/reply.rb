class Reply < ActiveRecord::Base
  belongs_to :issue
  after_create :send_issue_reply_email

  def send_issue_reply_email
    CustomerMailer.issue_reply_email(self).deliver_now
  end
end
