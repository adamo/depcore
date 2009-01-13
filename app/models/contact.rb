class Contact
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :nullable => false
  property :subject, String
  property :email, String, :nullable => false,:format => :email_address
  property :message, Text, :nullable => false
 
end
