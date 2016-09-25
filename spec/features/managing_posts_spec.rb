require 'spec_helper'

feature 'Managing blog posts' do

	context 'As a Guest user' do
		scenario 'Create new Post' do
			visit root_path
			expect(page).to_not have_link 'New Post'
		end
	end

	context 'As an Admin user' do
		background do
			email = 'admin@example.com'
			password = 'password'

			@admin = AdminUser.create(email: email, password: password)

			log_in_admin_user
		end

		def log_in_admin_user(email = 'admin@example.com', password: 'password')
			reset_session!
			visit admin_root_path
			fill_in 'Email', with: email
			fill_in 'Password', with: password
			click_button 'Login'
		end

		scenario 'Posting a new blog' do
			click_link 'Posts'
			click_link 'New Post'

			fill_in 'post_title', with: 'New Blog Post'
			fill_in 'post_body', with: 'This post was made from Admin Interface'
			click_button 'Create Post'

			expect(page).to have_content 'This post was made from Admin Interface'
		end

		context 'With an existing blog post' do
			background do
				@post = Post.create(title: 'Awesome', body: 'test text')
			end

			scenario 'Publishing an existing blog' do
				visit admin_post_path(@post)
				click_link 'Edit Post'

				check 'Published'
				click_button 'Update Post'

				expect(page).to have_content 'Post was successfully updated'
				expect(Post.last.published?).to be true
			end
		end
	end

	# scenario 'Guests cannot create posts' do
	# 	visit root_path
	# 	click_link 'New Post'

	# 	expect(page).to have_content 'Access denied'
	# end

	# scenario 'Posting a new blog' do
	# 	visit root_path

	# 	page.driver.browser.authorize 'cy', 'installfest'
	# 	click_link 'New Post'

	# 	expect(page).to have_content 'New Post'

	# 	fill_in 'Title', with: 'I love cheese'
	# 	fill_in 'Body', with: "It's pretty amazing, don't you think?"

	# 	click_button 'Create Post'
	# 	expect(page).to have_content 'I love cheese'
	# end

	# context 'with an existing blog post' do
	# 	background do
	# 		@post = Post.create(title: 'Awesome', body: 'test text')
	# 	end

	# 	scenario 'Editing an existing blog' do
	# 		visit post_path(@post)

	# 		page.driver.browser.authorize 'cy', 'installfest'
	# 		click_link 'Edit'

	# 		fill_in 'Title', with: 'Not Awesome'
	# 		click_button 'Update Post'

	# 		expect(page).to have_content 'Not Awesome'
	# 	end
	# end

	
end
