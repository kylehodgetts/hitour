require 'rails_helper'

RSpec.describe Answer, type: :model do
  context 'Creating an Answer' do
    before :all do
      @answer = Answer.new
    end
    after :all do
      @answer.destroy
    end
    describe 'without an answer value' do
      it 'should be rejected' do
        @answer = Answer.create(is_correct: false)
        expect(@answer.save).to be false
      end
    end
    describe 'with an empty answer value' do
      it 'should be rejected' do
        @answer = Answer.create(value: '', is_correct: false)
        expect(@answer.save).to be false
      end
    end
    describe 'without an is_correct value' do
      it 'should be accepted' do
        @answer = Answer.create(value: 'a')
        expect(@answer.save).to be true
      end
      it 'should default is_correct to false' do
        @answer = Answer.create(value: 'a')
        @answer.save
        expect(@answer.is_correct).to be false
      end
    end
    describe 'with a correct is_correct value' do
      it 'should set is_correct to true' do
        @answer = Answer.create(value: 'a', is_correct: true)
        @answer.save
        expect(@answer.is_correct).to be true
      end
    end
  end
end
