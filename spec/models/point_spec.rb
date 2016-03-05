require 'rails_helper'

RSpec.describe Point, type: :model do
  context 'Creating a Point' do
    before :each do
      @point = Point.new
    end
    after :each do
      @point.destroy
    end
    describe 'with a missing name' do
      it 'should be rejected' do
        @point = Point.create(name: '', description: 'description', url: 'url')
        expect(@point.save).to be false
      end
    end
    describe 'with a name shorter than 5 characters' do
      it 'should be rejected' do
        @point = Point.create(name: 'aaa', description: 'desc', url: 'url')
        expect(@point.save).to be false
      end
    end
    describe 'with a missing description' do
      it 'should be accepted' do
        @point = Point.create(name: 'a name', description: '', url: 'url')
        expect(@point.save).to be true
      end
    end
    describe 'with a missing url' do
      it 'should be accepted' do
        @point = Point.create(name: 'a name', description: 'desc')
        expect(@point.save).to be true
      end
    end
    describe 'with valid parameters' do
      it 'should be accepted' do
        @point = Point.create(name: 'a name', description: 'desc', url: 'url')
        expect(@point.save).to be true
      end
    end
  end
  context 'Updating a Point' do
    before :each do
      @point = Point.create(name: 'a name', description: 'desc', url: 'url')
      @point.save
    end
    after :each do
      @point.destroy
    end
    describe 'with a name shorter than 5 characters' do
      it 'should be rejected' do
        @point.name = 'aaa'
        expect(@point.save).to be false
      end
    end
    describe 'with a valid name' do
      it 'should be accepted' do
        @point.name = 'A longer name'
        expect(@point.save).to be true
      end
    end
    describe 'with a missing description' do
      it 'should be accepted' do
        @point.description = ''
        expect(@point.save).to be true
      end
    end
    describe 'with a populated description' do
      it 'should be accepted' do
        @point.description = 'A description'
        expect(@point.save).to be true
      end
    end
    describe 'with a missing url' do
      it 'should be accepted' do
        @point.url = ''
        expect(@point.save).to be true
      end
    end
    describe 'with a populated url' do
      it 'should be accepted' do
        @point.url = 'https://aurl.com'
        expect(@point.save).to be true
      end
    end
  end
end
