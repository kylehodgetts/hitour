require 'rails_helper'

RSpec.describe PointDatum, type: :model do
  context 'Creating a PointDatum pair' do
    before :all do
      @point = Point.create(name: 'a name', description: 'desc', url: 'url')
      @datum = Datum.create(title: 'title', description: 'desc', url: 'url')
      @point_datum = PointDatum.new
    end
    after :all do
      @point_datum.destroy
      @point.destroy
      @datum.destroy
    end

    describe 'without a rank' do
      it 'should be rejected' do
        @point_datum = PointDatum.create(point_id: @point.id,
                                         datum_id: @datum.id)
        expect(@point_datum.save).to be false
      end
    end
    describe 'with a rank greater than 0' do
      it 'should be accepted' do
        @point_datum = PointDatum.create(point_id: @point.id,
                                         datum_id: @datum.id,
                                         rank: 1)
        expect(@point_datum.save).to be true
      end
    end
    describe 'without a valid point' do
      it 'should be rejected' do
        @point_datum = PointDatum.create(datum_id: @datum.id,
                                         rank: 1)
        expect(@point_datum.save).to be false
      end
    end
    describe 'without a valid datum' do
      it 'should be rejected' do
        @point_datum = PointDatum.create(point_id: @point.id,
                                         rank: 1)
        expect(@point_datum.save).to be false
      end
    end
  end
end
