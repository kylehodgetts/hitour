require 'rails_helper'

RSpec.describe PointsDataController, type: :controller do
  def add_point_datum(point, datum, rank)
    PointDatum.create(point_id: point.id,
                      datum_id: datum.id,
                      rank: rank)
  end
  describe 'POST #create' do
    before(:each) do
      PointDatum.delete_all
      create_user_session
    end
    describe 'with valid parameters' do
      it 'should create a point datum' do
        point = create_point
        datum = create_datum
        post :create, point_datum: {
          point_id: point.id,
          datum_id: datum.id
        }
        expect(response.body).to eq '["Succesfully added media to point"]'
      end
      it 'should create a point datum with rank 2' do
        point = create_point
        # This will be point datum with rank 1
        PointDatum.create(point_id: point.id,
                          datum_id: create_datum.id,
                          rank: 1)
        datum = create_datum
        post :create, point_datum: {
          point_id: point.id,
          datum_id: datum.id
        }
        expect(response.body).to eq '["Succesfully added media to point"]'
        point_datum = PointDatum.where(point_id: point.id, datum_id: datum.id)
        expect(point_datum.exists?).to be_truthy
        expect(point_datum.first.rank).to eq 2
      end
    end
    describe 'with invalid parameters' do
      it 'should reject missing parameters' do
        point = create_point
        post :create, point_datum: {
          point_id: point.id
        }
        expect(response.body).to eq '["Datum can\'t be blank"]'
      end
      it 'should reject invalid datum' do
        point = create_point
        post :create, point_datum: {
          point_id: point.id,
          datum_id: '23455'
        }
        expect(response.body).to eq '["Datum can\'t be blank"]'
      end
    end
  end
  describe 'PATCH #increase_rank' do
    before(:each) do
      PointDatum.delete_all
      Point.delete_all
      Datum.delete_all
      create_user_session
    end
    it 'should increase to 2' do
      point = create_point
      # This will be point datum with rank 1
      point_datum = add_point_datum(point, create_datum, 1)
      add_point_datum(point, create_datum, 2)

      patch :increase_rank, id: point_datum.id
      expect(response.body).to include 'down'
      # Check rank has actually been Updated
      point_datum = PointDatum.find(point_datum.id)
      expect(point_datum.rank).to eq 2
    end
    it 'should decrease rank to 1' do
      point = create_point
      add_point_datum(point, create_datum, 1)
      # This will be point datum with rank 2
      point_datum = add_point_datum(point, create_datum, 2)

      patch :decrease_rank, id: point_datum.id
      expect(response.body).to include 'up'
      # Check rank has actually been Updated
      point_datum = PointDatum.find(point_datum.id)
      expect(point_datum.rank).to eq 1
    end
  end
  describe 'DELETE #destroy' do
    before(:each) do
      PointDatum.delete_all
      Point.delete_all
      Datum.delete_all
      create_user_session
    end
    it 'should decrease other point_datum ranks' do
      point = create_point
      # Create 4 Point Datums
      add_point_datum(point, create_datum, 1)
      # This should be deleted
      # When deleted - Point Datums with higher ranks should decrease
      to_delete = add_point_datum(point, create_datum, 2)
      should_be_2 = add_point_datum(point, create_datum, 3)
      should_be_3 = add_point_datum(point, create_datum, 4)
      delete :destroy, id: to_delete.id
      expect(response.body).to eq '["Succesfully deleted datum from point"]'
      # Should have moved point datums rank
      should_be_2 = PointDatum.find(should_be_2.id)
      expect(should_be_2.rank).to eq 2
      should_be_3 = PointDatum.find(should_be_3.id)
      expect(should_be_3.rank).to eq 3
    end
  end
end
