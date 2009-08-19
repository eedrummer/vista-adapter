require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class Vista::ConnectionFactory
  extend Mocha::Standalone
  
  # stubbing connection
  def self.connection
    mock('connection') do
      expects(:close)
    end
  end
end

class ConnectionHandlerTest < Test::Unit::TestCase
  include Vista::ConnectionHandler
    
  context 'Vista::ConnectionHandler' do
    # assert_raise won't work for Java exceptions created in ruby... it's a long story
    should 'still close the connection if a java exception is thrown' do
      import java.lang.NullPointerException
      begin
        with_connection do |connection|
          raise NullPointerException.new('game over')
        end
      rescue NullPointerException
        assert true
      end
    end
    
    should 'still close the connection if a ruby exception is thrown' do
      assert_raise StandardError do
        with_connection do |connection|
          raise StandardError.new('Boom!')
        end
      end
    end
  end
end