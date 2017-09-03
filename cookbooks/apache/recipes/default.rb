#
# Cookbook:: apache
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

execute 'apt-get update -y' if node['platform'] == 'ubuntu'

package node['apache']['package'] do
  action :install
end

node['apache']['sites'].each do |site_name, data|
  document_root = '/content/sites/' + site_name
  
  directory document_root do 
    mode '0755'
    recursive true
  end

  template_location = case node['platform']
                      when 'ubuntu' then '/etc/apache2/sites-enabled'
                      when 'centos' then '/etc/httpd/conf.d'
                      end
  template "#{template_location}/#{site_name}.conf" do 
    source 'vhost.erb'
    mode '0644'
    variables(
      document_root: document_root,
      port: data['port'],
      domain: data['domain']
    )
    notifies :restart, 'service[httpd]'
  end

  template "#{document_root}/index.html" do
    source 'index.html.erb'
    mode '0644'
    variables(
      site_title: data['site_title'],
      coming_soon: 'Coming soon'
    )
    notifies :restart, 'service[httpd]'
  end
end

execute 'rm /etc/httpd/conf.d/welcome.conf' do
  only_if do
    File.exist?('/etc/httpd/conf.d/welcome.conf')
  end
  notifies :restart, 'service[httpd]'
end

execute 'rm /etc/httpd/conf.d/README' do
  only_if do
    File.exist?('/etc/httpd/conf.d/README')
  end
end

service 'httpd' do
  service_name node['apache']['package']
  action [ :enable, :start ]
end

#include_recipe 'php::default'
