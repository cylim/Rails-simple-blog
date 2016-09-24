require 'spec_helper'

# describe Post do
#   it 'should validate presence of title' do
#   	post = Post.new
#   	post.valid?
#   	expect(post.errors.messages[:title]).to include "can't be blank"
#   end
# end

describe Post do
	describe 'validations' do
		subject(:post) { Post.new }
		before { post.valid? }

		[:title, :body].each do |attr|
			it "should validate presence of #{attr}" do
				expect(post.errors[attr].size).to be >= 1
				expect(post.errors.messages[attr]).to include "can't be blank"
			end
		end
	end
end