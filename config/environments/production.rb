#Merb.logger.info("Loaded PRODUCTION Environment...")
Merb::Config.use { |c|
  c[:exception_details] = false
  c[:reload_classes] = false
  c[:log_level] = :error
  
  c[:log_file]  = Merb.root / "log" / "production.log"
  # or redirect logger using IO handle
  # c[:log_stream] = STDOUT
}

Merb::BootLoader.after_app_loads do
  Merb::Cache.setup do
    register(:page_store, Merb::Cache::PageStore[Merb::Cache::FileStore], :dir => Merb.root / "public")
    register(:action_store, Merb::Cache::ActionStore[Merb::Cache::FileStore], :dir => Merb.root / "tmp")
    register(:default, Merb::Cache::AdhocStore[:page_store, :action_store])
  end
end