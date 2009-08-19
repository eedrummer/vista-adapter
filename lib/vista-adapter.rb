if RUBY_PLATFORM =~ /java/
  require 'rubygems'
  require 'java'
  require 'find'
  
  Find.find(File.expand_path(File.dirname(__FILE__) + '/jars')) do |path|
    require path if path.match(/\.jar$/)
  end
  
  import com.medsphere.fileman.FMField
  import com.medsphere.fileman.FMUtil
  import com.medsphere.fileman.FMFile
  import com.medsphere.fileman.FMQueryList

  import com.medsphere.resource.ResAdapter
  import com.medsphere.rpcresadapter.RPCResAdapter

  import com.medsphere.fileman.FMScreenValue
  import com.medsphere.fileman.FMScreenEquals
  import com.medsphere.fileman.FMScreenField
  import com.medsphere.fileman.FMScreenIEN

  import com.medsphere.vistalink.VistaLinkRPCConnection
  import com.medsphere.ovid.domain.ov.PatientRepository
  import com.medsphere.vistarpc.RPCResponse
  import com.medsphere.vistarpc.VistaRPC
  
  require File.expand_path(File.dirname(__FILE__) + '/vista/connection_factory')
  require File.expand_path(File.dirname(__FILE__) + '/vista/connection_handler')
  require File.expand_path(File.dirname(__FILE__) + '/vista/rpc')
  require File.expand_path(File.dirname(__FILE__) + '/active_file_man/extensions/symbol')
  require File.expand_path(File.dirname(__FILE__) + '/active_file_man/associations')
  require File.expand_path(File.dirname(__FILE__) + '/active_file_man/base')
  require File.expand_path(File.dirname(__FILE__) + '/models/patient')
  require File.expand_path(File.dirname(__FILE__) + '/models/race')
  require File.expand_path(File.dirname(__FILE__) + '/models/marital_status')
  require File.expand_path(File.dirname(__FILE__) + '/models/allergy')
  require File.expand_path(File.dirname(__FILE__) + '/models/vital_sign')
  require File.expand_path(File.dirname(__FILE__) + '/models/pharmacy_orderable_item')
  require File.expand_path(File.dirname(__FILE__) + '/models/drug')
  require File.expand_path(File.dirname(__FILE__) + '/models/medication')
  
else
  warn "vista adapter is only for use with JRuby"
end