module VideosHelper
	def extract_id youtube_link
		m = youtube_link.match /watch\?v=(\w+)/
		return nil if m.nil?
  	m[1]
	end
end
