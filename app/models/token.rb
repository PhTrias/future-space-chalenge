class Token < ApplicationRecord

  belongs_to :user

  def expired?
    self.expiration > DateTime.now
  end
end
