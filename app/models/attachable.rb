require 'fileutils'
module Attachable
  include FileUtils
  
  UPLOAD_PATH = 'public/uploads' 

  def attachments
    @attachments = Attachment.all(:attachable_type => self.class,
      :attachable_id => self.id)
  end
  
  def attachment
    @attachment ||= Attachment.
      first :attachable_type=>self.class,:attachable_id => self.id
  end

  def has_attached_file?
    attachment
    return !@attachment.nil?
  end

  def attachment_path
    "uploads/#{@attachment.id}/#{@attachment.filename}" unless @attachment.nil?
  end

  def attachment= value
    attachment = value
    unless value.empty?
      @attachment = Attachment.create( :attachable_type => self.class,
        :attachable_id => self.id,
        :filename => attachment[:filename],
        :content_type => attachment[:content_type],
        :size => attachment[:size]
      )

      FileUtils.makedirs "public/uploads/#{@attachment.id}"
      mv(attachment[:tempfile].path, "#{UPLOAD_PATH}/#{@attachment.id}/#{@attachment.filename}")
    end
  end

  protected
  # Partition the path according to the id
  def partitioned_path id
    ("%06d" % id).scan(/.../)
  end
end