require 'test_helper'
require 'node/external'

context "An external node" do
  setup do
    ElasticSearch::Node::External.new
  end
  
  teardown do
    topic.close
  end
  
  asserts(:ip).kind_of?(String)
  asserts(:port).kind_of?(Integer)
end