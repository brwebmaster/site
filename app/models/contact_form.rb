class ContactForm < MailForm::Base
	attribute :name, :validate => true
	attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  	attribute :file,      :attachment => true
    attribute :inquiry

  	attribute :message
  	attribute :nickname,  :captcha  => true

  	def headers
    {
      :subject => "Contact Form",
      :to => "brwebmaster@lists.stanford.edu",
      :from => %("#{name}" <#{email}>)
    }
  end
end