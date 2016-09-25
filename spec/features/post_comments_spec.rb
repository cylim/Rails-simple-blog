require 'spec_helper'

feature 'Posting Comments' do
	background do
		@post = Post.create(title: 'Awesome', body: 'test text', published: true)
	end

	scenario 'Posting a comment' do
		visit post_path(@post)

		comment = 'This is comment!'

		fill_in 'comment_body', with: comment
		click_button 'Add comment'

		expect(page).to have_content comment
	end
end
