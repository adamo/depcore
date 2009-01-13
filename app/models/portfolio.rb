require 'attachable'
class Portfolio
  include DataMapper::Resource
  include Attachable

  after :save, :update_attachment_id

  property :id, Serial
  property :name, String, :length => 3..140 #autovalidation
  property :description, Text, :nullable=>false
  property :description_pl,Text,:nullable=>false,:default=>''
  property :web_url, String, :limit=>160
  property :created_at, DateTime

  validates_present :attachment

  private
  def update_attachment_id
    @attachment.update_attributes(:attachable_id => self.id)
  end
end