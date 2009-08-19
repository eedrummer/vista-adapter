module Vista
  class RPC
    include Vista::ConnectionHandler
    
    def initialize(rpc_name, *params)
      @rpc_name, @params = rpc_name, params
    end
    
    def execute
      result = nil
      
      with_connection do |connection|
        connection.setContext(FMUtil::FM_RPC_CONTEXT)
        rpc = VistaRPC.new(@rpc_name, RPCResponse::ResponseType::ARRAY)
        @params.each_with_index do |param, i|
          rpc.set_param(i + 1, param)
        end
        response = connection.execute(rpc)
        result = response.array
      end
      
      result
    end
  end
end