class Comments < Application
  # provides :xml, :yaml, :js
  before :get_post,:exclude=>:index
  
  def index
    @comments = Comment.all
    display @comments
  end

  def show(id)
    @comment = Comment.get(id)
    raise NotFound unless @comment
    display @comment
  end

  def new
    only_provides :html
    @comment = Comment.new
    display @comment
  end

  def edit(id)
    only_provides :html
    @comment = Comment.get(id)
    raise NotFound unless @comment
    display @comment
  end

  def create(comment)
    @comment = @post.comments.build(comment)
    @comment.admin = true if authenticated?
    
    if @comment.save
      redirect resource(@post), :message => {:notice => "Your comment was saved, thank you."}
      
      m= Merb::Mailer.new :to => 'adam@depcore.com',
                     :from => @comment.email,
                     :subject => ' New comment ',
                     :text => "Post: #{@post.title}, by #{@comment.email}"
    else
      #render @comment.post
      redirect resource(@post), :message => {:error => "Comment failed to be created, please check your email address and the required fields"}
    end
  end

  def update(id, comment)
    @comment = Comment.get(id)
    raise NotFound unless @comment
    if @comment.update_attributes(comment)
       redirect resource(@comment)
    else
      display @comment, :edit
    end
  end

  def destroy(id)
    @comment = Comment.get(id)
    raise NotFound unless @comment
    if @comment.destroy
      redirect resource(@post,:comments)
    else
      raise InternalServerError
    end
  end
  
  private
  def get_post
    @post = Post.get( params[:post_id] )
  end
end 