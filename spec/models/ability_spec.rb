require 'rails_helper'

describe Ability  do
  subject(:ability){ Ability.new(stuff) }

  describe 'for guest' do
    let(:stuff){ nil }

    it { should be_able_to :create, Ticket }
    it { should be_able_to :show, Ticket }
    it { should be_able_to :update, Ticket }
    it { should_not be_able_to :manage, :all }
  end
=begin
  describe 'for admin' do
    let(:user){ create :user, admin: true }

    it { should be_able_to :manage, :all }
  end
=end
  describe 'for stuff' do

    let(:stuff){ create :stuff }
    let(:other_stuff){ create :stuff }
    let(:ticket){ create :ticket, stuff: stuff }
    let(:other_ticket){ create :ticket, stuff: other_stuff }
    let(:un_owned_ticket){ create :ticket }


    it { should_not be_able_to :manage, :all }    

    it { should be_able_to :stuff_update, ticket }
    it { should be_able_to :stuff_update, un_owned_ticket }
    it { should_not be_able_to :stuff_update, other_ticket }

  end   
=begin
    it { should be_able_to :destroy, create(:comment, body: 'Text',commentable: some_answer, user: user) }
    it { should_not be_able_to :destroy, create(:comment, body: 'Text', commentable: some_answer, user: other_user) }

    it { should_not be_able_to :upvote, answer }
    it { should be_able_to :upvote, some_other_answer }

    it { should_not be_able_to :upvote, question }
    it { should be_able_to :upvote, other_question }

    it { should_not be_able_to :downvote, answer }
    it { should be_able_to :downvote, some_other_answer }

    it { should_not be_able_to :downvote, question }
    it { should be_able_to :downvote, other_question }

    it { should be_able_to :destroy, create(:vote, votable: some_answer, vote_field: 1, user: user)}
    it { should_not be_able_to :destroy, create(:vote, votable: some_answer, vote_field: 1, user: other_user)}

    it { should be_able_to :destroy, create(:attachment, attachable: answer)}
    it { should_not be_able_to :destroy, create(:attachment, attachable: some_other_answer)}

    it { should be_able_to :best, best_answer }
    it { should_not be_able_to :best, best_other_answer }

    it { should be_able_to :me, user, user: user }
    it { should_not be_able_to :me, other_user, user: user }  

    context "with subscription" do
      let!(:question) { create :question }

      context "when user is not subscribed to question" do
        let(:subscription) { build :subscription, user_id: user.id, question: question }

        it { should     be_able_to :create,  subscription }
        it { should_not be_able_to :destroy, subscription, user_id: user.id }
      end

      context "when user subscirbed to question" do
        let!(:subscription) { create :subscription, user_id: user.id, question: question }

        it { should     be_able_to :destroy, subscription, user_id: user.id }
        it { should_not be_able_to :create,  subscription, user_id: user.id }
      end
    end       
    
  end
=end
end