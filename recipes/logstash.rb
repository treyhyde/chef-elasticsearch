
apt_repository 'logtstash' do
  uri        'http://packages.elasticsearch.org/logstash/1.3/debian'
  components ['main', 'stable']
  key 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch'
end

package "logstash" do
  action :upgrade # see actions section below
end

