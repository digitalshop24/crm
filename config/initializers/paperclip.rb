Paperclip.interpolates(:s3_missing_url) do |attachment, style|
  "#{attachment.s3_protocol(style, true)}//#{attachment.s3_host_name}/#{attachment.bucket_name}/noimage/:class/:attachment/missing_#{style}"
end
Paperclip::Attachment.default_options.update(
  storage: :s3,
  path: "/:class/:attachment/:id_partition/:style/:filename",
  s3_host_name: "s3-eu-central-1.amazonaws.com",
  url: ":s3_domain_url",
  default_url: ":s3_missing_url.jpg",
  s3_credentials: {
    bucket: 'redstudent',
    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
  }
)