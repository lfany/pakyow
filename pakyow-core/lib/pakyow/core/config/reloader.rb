Pakyow::Config.register :reloader do |config|

  # if true, the app will be reloaded on every request
  config.opt :enabled, true

end.env :test do |opts|
  opts.enabled = false
end.env :production do |opts|
  opts.enabled = false
end
