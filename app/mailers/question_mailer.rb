class QuestionMailer < Merb::MailController

  def notify
    @contact = params[:contact]
    render_mail
  end
  
end