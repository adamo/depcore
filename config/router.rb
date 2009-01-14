#Merb.logger.info("Compiling routes...")
Merb::Router.prepare do
  resources :tags do |tags|
    tags.resources :posts
  end

  resources :posts, 
    :path=>"blogposts",
    :member=>{:publish=>:get},
    :collection=>{:pages=>:get} do |post|
      post.resources :comments
  end

  resources :portfolios
  slice(:merb_auth_slice_password, :name_prefix => nil, :path_prefix => "")

  match('/about').to(:controller => 'index', :action => 'about')
  match('/contact').to(:controller => 'index',:action => 'contact')
  match('/send_question').to(:controller => 'index', :action =>'send_question')
  match('/').to(:controller => 'index', :action =>'home')
  #match('/:year/:month/:title').to(:controller=>'blogs',:action=>'show').name(:post)
  
  # TODO jak zrobione tłumaczenie wrócić do tej wersji
  #match(/\/?(en|pl)?/).to(:locale => "[1]") do |l|
  # match('/about').to(:controller => 'index', :action => 'about')
  # match('/contact').to(:controller => 'index',:action => 'contact')
  # match('/send_question').to(:controller => 'index', :action =>'send_question')
  # match('(/:l)').to(:controller => 'index', :action =>'home')
  # match('/').to(:controller => 'index', :action =>'home')
  # match('/home').to(:controller => 'index', :action =>'home')
  #end
end