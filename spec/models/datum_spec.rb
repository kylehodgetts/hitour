require 'rails_helper'

RSpec.describe Datum, type: :model do
  before :each do
    @datum = Datum.new
  end
  after :each do
    @datum.destroy
  end
  context 'Creating a Datum' do
    describe 'with a missing title' do
      it 'should be rejected' do
        @datum = Datum.create(description: 'description', url: 'url')
        expect(@datum.save).to be false
      end
    end
    describe 'with an empty title' do
      it 'should be rejected' do
        @datum = Datum.create(title: '', description: 'description', url: 'url')
        expect(@datum.save).to be false
      end
    end
    describe 'with a missing description' do
      it 'should be rejected' do
        @datum = Datum.create(title: 'title', url: 'url')
        expect(@datum.save).to be false
      end
    end
    describe 'with an empty description' do
      it 'should be rejected' do
        @datum = Datum.create(title: 'title', description: '', url: 'url')
        expect(@datum.save).to be false
      end
    end
    describe 'with a missing url' do
      it 'should be accepted' do
        @datum = Datum.create(title: 'title', description: 'desc')
        expect(@datum.save).to be true
      end
    end
    describe 'with a empty url' do
      it 'should be accepted' do
        @datum = Datum.create(title: 'title', description: 'desc', url: '')
        expect(@datum.save).to be true
      end
    end
    describe 'with valid inputs' do
      it 'should be accepted' do
        @datum = Datum.create(title: 'title', description: 'desc', url: 'url')
        expect(@datum.save).to be true
      end
    end
  end
  context 'Updating a datum' do
    before :each do
      @datum = Datum.create(title: 'title', description: 'description',
                            url: 'url.com')
      @datum.save
    end
    describe 'with an empty title' do
      it 'should be rejected' do
        @datum.title = ''
        expect(@datum.save).to be false
      end
    end
    describe 'with an empty description' do
      it 'should be rejected' do
        @datum.description = ''
        expect(@datum.save).to be false
      end
    end

    describe 'with a empty url' do
      it 'should be accepted' do
        @datum.url = ''
        expect(@datum.save).to be true
      end
    end
  end
end
