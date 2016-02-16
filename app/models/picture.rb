class Picture < ActiveRecord::Base

  belongs_to :gallery

  has_attached_file :image,
  :styles => { :large => "300x300<", :medium => "300x300>", :thumb => "100x100>" },
    :path => ":rails_root/public/images/:id/:filename",
    :url  => "/images/:id/:filename"

  do_not_validate_attachment_file_type :image

end