require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class Vista::RPC
  include Mocha::Standalone
  
  # stubbing connection
  def with_connection
    mock_result = mock('result')
    mock_result.expects(:array).returns('eleventeen')
    mock_connection = mock('connection') do
      expects(:setContext)
      expects(:execute).returns(mock_result)
    end
    yield mock_connection
  end
end

class RPCTest < Test::Unit::TestCase
    
  context 'Vista::RPC' do
    should 'properly execute a VistA RPC Call' do
      rpc = Vista::RPC.new("ORQQAL LIST", '42')
      result = rpc.execute
      assert_equal 'eleventeen', result
    end
    
  end
end