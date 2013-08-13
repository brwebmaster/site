class ContactFormController < ApplicationController
  def new
  	@contact_form = ContactForm.new
  	@my_variable = 'HelloJLKLKJLKJ'
  end

  def create
  	begin
  		@contact_form = ContactForm.new(params[:contact_form])
  		@contact_form.request = request
  		if @contact_form.deliver
  			flash.now[:notice] = 'Thank You for Your Message!'
  		else
  			redirect_to :action => :new
  		end
  	rescue ScriptError
  		flash[:error] = 'Sorry, this message appears to be spam and was not delivered'
  	end
end
end
