
apt_repository 'logtstash' do
  uri        'http://packages.elasticsearch.org/logstash/1.3/debian'
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

cookbook_file "/etc/defaults/logstash" do
  source 'logstash.defaults'
  action :create
  owner 'root'
  group 'root'
  mode 0444
  notifies :restart, "service[logstash]"
end


cookbook_file "/etc/init.d/logstash" do
  source 'logstash.rc'
  action :create
  owner 'root'
  group 'root'
  mode 0555
  notifies :restart, "service[logstash]"
end

service "logstash" do
  supports :status=>true, :restart=>true, :start=>true, :stop=>true
  action [ :enable, :start ]
  enabled true
end


