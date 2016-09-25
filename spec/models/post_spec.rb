require 'spec_helper'

# describe Post do
#   it 'should validate presence of title' do
#   	post = Post.new
#   	post.valid?
#   	expect(post.errors.messages[:title]).to include "can't be blank"
#   end
# end

describe Post do

	describe '#author_name' do
		context 'when the author exists' do
			let(:author) { AdminUser.new }
			subject { Post.new(author: author).author_name }

			before { author.stub(:name){ "Jane Smith" }}

			it { should eq "Jane Smith"}
		end

		context 'when the author doesnt exist' do
			subject { Post.new.author_name }

			it { should eq "Nobody" }
		end
	end

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

	describe '#content' do
		let(:markdown_service) { double('MarkdownService') }

		before do
			MarkdownService.stub(:new) { markdown_service }
		end

		it 'should convert its body to markdown' do
			markdown_service.should_receive(:render).with('post body')
	  		Post.new(body: 'post body').content
		end
	end
end