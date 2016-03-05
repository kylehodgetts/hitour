require 'rails_helper'

RSpec.describe ToursController, type: :controller do
  def create_tour
    Tour.delete_all
    audience = Audience.create(name: 'Adult')
    tour = Tour.create(name: 'Test Tour',
                       audience_id: audience.id,
                       notes: 'Test Note')
    tour.save
    tour
  end
  describe 'POST #create' do
    before(:each) do
      create_user_session
      audience = Audience.create(name: 'Adult')
      post :create, tour:
        {
          name: 'Test Tour',
          audience_id: audience.id,
          notes: 'This is a test note'
        }
    end
    it 'should have created a new tour' do
      tour = Tour.find_by name: 'Test Tour'
      expect(tour).to_not eq(nil)
    end
  end

  describe 'PATCH #update' do
    before(:each) do
      create_user_session
      @tour = create_tour
    end
    it 'should update tours name' do
      patch :update, id: @tour.id, tour:
        {
          name: 'New Tour Name'
        }
      # Search for tour again
      tour = Tour.find(@tour.id)
      expect(tour.name).to eq 'New Tour Name'
    end
    it 'should have updated tour notes' do
      patch :update, id: @tour.id, tour:
        {
          notes: 'Notes changed'
        }
      # Search for tour again
      tour = Tour.find(@tour.id)
      expect(tour.notes).to eq 'Notes changed'
    end
  end
  describe 'DELETE #destroy' do
    before(:each) do
      create_user_session
      @tour = create_tour
    end
    it 'should have deleted tour' do
      post :destroy, id: @tour.id
      # Attempt to find tour again
      tour = Tour.find_by_id(@tour.id)
      expect(tour).to eq nil
    end
  end
end
