#!/usr/bin/env ruby

es_version = ENV['ES_VERSION'] || "0.19.1"

`curl https://github.com/downloads/elasticsearch/elasticsearch/elasticsearch-#{es_version}.tar.gz -L -o elasticsearch.tar.gz`
`tar xvf elasticsearch.tar.gz`
#mv elasticsearch-$ES_VERSION elasticsearch
File.unlink "elasticsearch-#{es_version}.tar.gz"