class Launch < ApplicationRecord

  before_save :save_import_date_and_status

  validates :name, presence: true

  enum import_status: ["draft", "trash", "published"]

  def save_import_date_and_status
    self.imported_t = DateTime.now
    self.import_status = 'published'
  end

  def need_update?(data)
    code = Digest::MD5.hexdigest(data)

    code != self.last_import_code
  end
end
