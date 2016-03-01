class TourSession < ActiveRecord::Base
    PASSPHRASE_REGEX = /\A[A-z]+\z/i
    belongs_to :tour

    # validates :name, presence: :true
    # validates :passphrase, presence: :true,
    #                        format: { with: PASSPHRASE_REGEX },
    #                        length: { minimum: 5 }

    auto_strip_attributes :passphrase, squish: true
end
