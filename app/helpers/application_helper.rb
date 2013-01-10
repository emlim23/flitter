module ApplicationHelper
	def title
		base_title = "Flitter"
		if @title.nil?
			base_title
		else
			"#{base_title} - #{@title}"
		end
	end

	def logo
		image_tag("logo_header.png", :alt => "Flitter", :class => "round")
	end
end
