class Post < ApplicationRecord
	has_many :comments

	validates_presence_of :body, :title

	def content
		MarkdownService.new.render(body)
	end
end
