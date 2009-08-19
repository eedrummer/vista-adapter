module Vista
  # Class that creates connections to VistA
  class ConnectionFactory
    CONFIG_FILE = ENV["vista.config"] || File.dirname(__FILE__) + "/../../config/vista.yml"
    CONFIG = YAML.load_file(CONFIG_FILE)
    # TODO: Replace with real, configurable code
    def self.connection
      VistaLinkRPCConnection.new(CONFIG["host"], CONFIG["port"], CONFIG["access_code"], CONFIG["verify_code"])
    end
  end
end