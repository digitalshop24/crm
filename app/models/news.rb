class News < ActiveRecord::Base
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
