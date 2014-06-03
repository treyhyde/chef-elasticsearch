
apt_repository 'logtstash' do
  uri        'http://packages.elasticsearch.org/logstash/1.4/debian'
  components ['stable', 'main']
  key 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch'
end

package "logstash" do
  action :upgrade # see actions section below
end


cookbook_file "/etc/logstash/conf.d/from_cd.conf" do
  source 'from_cd.conf'
  action :create
  owner 'root'
  group 'root'
  mode 0444
  notifies :restart, "service[logstash]"
end

cookbook_file "/etc/default/logstash-web" do
  source 'logstash-web.defaults'
  action :create
  owner 'root'
  group 'root'
  mode 0444
  notifies :restart, "service[logstash-web]"
end

cookbook_file "/opt/logstash/vendor/kibana/app/dashboards/default.json" do
  source 'monolith.json'
  action :create
  owner 'root'
  group 'root'
  mode 0444
  notifies :restart, "service[logstash-web]"
end


service "logstash" do
  provider Chef::Provider::Service::Upstart
  supports :status=>true, :restart=>true, :start=>true, :stop=>true
  action [ :enable, :start ]
  enabled true
end

service "logstash-web" do
  provider Chef::Provider::Service::Upstart
  supports :status=>true, :restart=>true, :start=>true, :stop=>true
  action [ :enable, :start ]
  enabled true
end

