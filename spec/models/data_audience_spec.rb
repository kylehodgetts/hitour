require 'rails_helper'

RSpec.describe DataAudience, type: :model do
  context 'Creating a DataAudience pair' do
    before :each do
      @datum = Datum.create(title: 'title', description: 'desc', url: 'url')
      @datum.save
      @audience = Audience.create(name: 'Audience')
      @audience.save
      @data_audience = DataAudience.new
    end
    after :each do
      @datum.destroy
      @audience.destroy
      @data_audience.destroy
    end
    describe 'With a missing datum' do
      it 'should be rejected' do
        @data_audience = DataAudience.create(audience_id: @audience.id)
        expect(@data_audience.save).to be false
      end
    end
    describe 'with an invalid datum' do
      it 'should be rejected' do
        invalid_id = Datum.last.id + 1
        @data_audience = DataAudience.create(audience_id: @audience.id,
                                             datum_id: invalid_id)
        expect(@data_audience.save).to be false
      end
    end
    describe 'With a missing audience' do
      it 'should be rejected' do
        @data_audience = DataAudience.create(datum_id: @datum.id)
        expect(@data_audience.save).to be false
      end
    end
    describe 'with an invalid audience' do
      it 'should be rejected' do
        invalid_id = Audience.last.id + 1
        @data_audience = DataAudience.create(audience_id: invalid_id,
                                             datum_id: @datum.id)
        expect(@data_audience.save).to be false
      end
    end
  end
end
