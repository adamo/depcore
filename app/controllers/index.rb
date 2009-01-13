class Index < Application
  #cache :home, :contact, :about

  def home
    render
  end

  def contact
    @contact = Contact.new
    render
  end

  def about
    render
  end

  def send_question
    @contact = Contact.new params[:contact]

    m = Merb::Mailer.new :to => 'adam@depcore.com',
                     :from => @contact.email,
                     :subject => @contact.subject,
                     :text => "From: #{@contact.email} \n #{@contact.message}"
    if @contact.valid? 
      if  m.deliver!
         redirect '/contact' , :message=>{:notice=> 'The message was send. Thank you.'}
       else
         redirect '/contact', :message=>{:error => 'The was a problem while sending the message. Sorry about that.'}
       end
    else
      redirect '/contact' , :message=>{:error=> 'Please fill out the form correctly.'}
    end
  end
end
