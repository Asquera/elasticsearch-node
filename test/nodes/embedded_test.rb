if 'jruby' == RUBY_ENGINE
  require 'test_helper'
  require 'node/embedded'
  
  context "An embedded node" do
    setup do
      ElasticSearch::Node::Embedded.new
    end
    
    asserts(:ip).kind_of?(String)
    asserts(:port).kind_of?(Integer)
  end
end