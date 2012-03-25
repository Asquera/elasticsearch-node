rm -rf elasticsearch # remove old version
curl https://github.com/downloads/elasticsearch/elasticsearch/elasticsearch-$ES_VERSION.tar.gz -L -o elasticsearch.tar.gz
tar xvf elasticsearch.tar.gz
mv elasticsearch-$ES_VERSION elasticsearch
rm elasticsearch.tar.gz
