default['apache']['sites']['fiverr2'] = { 
  'site_title' => 'Fiverr 2 website coming soon',
  'port' => 80, 
  'domain' => 'fiverr2.mylabserver.com' 
}
default['apache']['sites']['fiverr2b'] = { 
  'site_title' => 'Fiverr 2b website coming soon',
  'port' => 80, 
  'domain' => 'fiverr2b.mylabserver.com' 
}
default['apache']['sites']['fiverr3'] = {
  'site_title' => 'Fiverr 3  website coming soon',
  'port' => 80,
  'domain' => 'fiverr3.mylabserver.com'
}

default['apache']['package'] = case node['platform']
                               when 'ubuntu' then 'apache2'
                               when 'centos' then 'httpd'
                               end
