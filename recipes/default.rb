#
# Cookbook Name:: elasticsearch
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#


apt_repository 'elasticsearch' do
  uri        'http://packages.elasticsearch.org/elasticsearch/1.0/debian'
  components ['main', 'stable']
end

package "elasticsearch" do
  action :upgrade # see actions section below
end
