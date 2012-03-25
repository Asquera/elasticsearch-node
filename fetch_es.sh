rm -rf elasticsearch # remove old version
curl https://github.com/downloads/elasticsearch/elasticsearch/elasticsearch-$ES_VERSION.tar.gz -o elasticsearch.tar.gz
tar xvf elasticsearch.tar.gz
rm elasticsearch.tar.gz
