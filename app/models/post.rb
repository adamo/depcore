class Post
  include DataMapper::Resource
  include Merb::ControllerMixin

  has n,:comments
  before :save, :sanitize
  
  property :id, Serial
  property :title,String, :nullable=>false,:unique=>true
  property :html_content,Text, :nullable=>false
  property :text_content, Text
  property :published,Boolean,:default=>0
  property :created_at,DateTime
  property :published_at,Date
  property :commentable,Boolean,:default=>true
  property :views,Integer,:default=>0
  
  def sanitize
    self.text_content = escape_xml(self.html_content) unless self.html_content.blank?
  end
  
  def self.published
    all :published=>true,:order=>[:published_at.desc,:created_at.desc]
  end
  
  def publish
    self.update_attributes :published=>true,:published_at=>Time.now.to_date
  end
  
  def base_text
    self.html_content.split('<!-- more -->')[0]
  end
end