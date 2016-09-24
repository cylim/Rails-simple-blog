require 'spec_helper'

describe Comment do
  describe 'validations' do
  	subject(:comment) { Comment.new }
  	before { comment.valid? }

  	[:post, :body].each do |attr|
  		it "should validate presence of #{attr}" do
  			expect(comment.errors[attr].size).to be >= 1
  			expect(comment.errors.messages[attr]).to include "can't be blank"
  		end
  	end
  end
end
