class Post < ApplicationRecord
	has_many :comments

	validates_presence_of :body, :title

	scope :published, -> { where(published: true)}

	def content
		MarkdownService.new.render(body)
	end
end
