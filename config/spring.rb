%w(
  .ruby-version
  .rbenv-vars
  tmp/restart.txt
  tmp/caching-dev.txt
).each { |path| Spring.watch(path) }
Spring.application_root = '/home/ubuntu/rails_apps/devise-pundit/config/application.rb'