module Vista
  module ConnectionHandler

    # Provides a connection to VistA to the block that is passed in.
    # This method will take care of opening/closing the connection
    # as well as passing through any uncaught exceptions. This is important
    # becasue VistA doesn't handle improperly closed connections well.
    # They seem to cause a MUMPS process to go insanse on the server 
    # side (100% CPU usage).
    def with_connection
      begin
        connection = ConnectionFactory.connection
        yield connection
      ensure
        connection.close
      end
    end
  end
end