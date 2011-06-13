require_recipe "drupal::minimal"
require_recipe "nginx"

if node[:hosts].has_key(:localhost_aliases)
  node[:hosts][:localhost_aliases].each do |site|
    # Configure the development site
    nginx_app site do
      template "nginx_sites.conf.erb"
      server_name site
      server_aliases [site]
      docroot "/vagrant/public/#{site}/www"
    end
  end
end
