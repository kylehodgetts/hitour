class TourSession < ActiveRecord::Base
    belongs_to :tour
    auto_strip_attributes :passphrase, squish: true
end
