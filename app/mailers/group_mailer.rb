class GroupMailer < ApplicationMailer
    
  # groupsコントローラから値を受け取る→送信されるメールに内容あ反映させる
  def send_mail(mail_title,mail_content,group_users) #send_mailメソッドに対し引数を設定
	@mail_title =mail_title
	@mail_content =mail_content
	mail bcc: group_users.pluck(:email),subject: mail_title
  end
	
end
