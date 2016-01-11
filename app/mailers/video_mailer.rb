class VideoMailer < ActionMailer::Base
  default from: "basmatiraaswebmaster@gmail.com"

  def video_email(video)
    @video = video
    @url  = 'http://example.com/login'
    mail(to: '1516brdancers@lists.stanford.edu', subject: 'A New Video has been Added')
  end
end
