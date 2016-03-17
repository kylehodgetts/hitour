require 'rails_helper'

RSpec.describe PointsController, type: :controller do
  describe 'POST #create' do
    before(:each) do
      Point.delete_all
      create_user_session
    end
    describe 'with valid parameters' do
      it 'should create point' do
        post :create,
             name: 'Test Point',
             file: fixture_file_upload('/files/test_image.jpg', 'image/jpg'),
             description: 'This is a test data upload'
        expect(response).to redirect_to points_path
        expect(Point.where(name: 'Test Point').exists?).to be_truthy
      end
    end
    describe 'with missing file' do
      it 'should not create point' do
        # Check no point is initially in db
        expect(Point.all.size).to eq 0
        post :create,
             name: 'Test Point',
             description: 'This is a test data upload'
        # Should be no increase in number of points
        expect(Point.all.size).to eq 0
      end
    end
  end
  describe 'PATCH #update' do
    before(:each) do
      Point.delete_all
      create_user_session
    end
    describe 'with valid update params' do
      it 'should update points name' do
        point = Point.create(name: 'Test Point',
                             description: 'Test descrip',
                             url: 'https://s3-us-west-2.amazonaws.com/hitourbucket/Notes.txt')
        patch :update, id: point.id, point: {
          name: 'New Point Name'
        }
        expect(response.body).to eq '["Successfully updated point"]'
      end
    end
    describe 'with missing update params' do
      it 'should raise Parameter missing error' do
        point = Point.create(name: 'Test Point',
                             description: 'Test descrip',
                             url: 'https://s3-us-west-2.amazonaws.com/hitourbucket/Notes.txt')
        expect { patch(:update, id: point.id) }
          .to raise_error ActionController::ParameterMissing
      end
    end
  end
end
