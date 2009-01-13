class Attachment
  include DataMapper::Resource

  property :id, Serial
  property :filename, String
  property :content_type, String
  property :size, Integer
  property :attachable_id, Integer
  property :attachable_type, String

  def url
    "/uploads/#{self.id}/#{self.filename}"
  end
end