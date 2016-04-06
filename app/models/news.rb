class News < ActiveRecord::Base
  has_attached_file :image,
    styles: { thumb: "200x200", medium: "500x500>", big: "1000x1000>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
