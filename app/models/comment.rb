class Comment
  include DataMapper::Resource
  include Merb::ControllerMixin
  before :save, :sanitize
  
  belongs_to :post
  property :id, Serial
  property :post_id,Integer
  property :author,String,:limit=>50,:nullable=>false
  property :email,String,:format=>:email_address
  property :url,String
  property :text_textile,Text,:nullable=>false
  property :published,Boolean,:default=>true
  property :created_at,DateTime
  property :admin,Boolean,:default=>false

  # TODO przeniesć to do jakiegoś modułu
  def sanitize
    self.text_textile = escape_xml(self.text_textile) unless self.text_textile.blank?
  end
end