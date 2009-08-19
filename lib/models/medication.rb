class Medication
  attr_accessor :name, :generic_name, :ndc, :status, :order_id, :message
  
  def self.initialize_med_repo
    @med_repo = {}
    drugs = Drug.find_all
    pharmacy_orderable_items = PharmacyOrderableItem.find_all
    
    drugs.each do |drug|
      matching_poi = pharmacy_orderable_items.find {|poi| poi.ien == drug.pharmacy_orderable_item}
      if matching_poi
        @med_repo["#{matching_poi.name} #{matching_poi.dosage_form}"] = {:generic_name => drug.generic_name, :ndc => drug.ndc}
      end
    end
  end
  
  def self.find_med_info(dd_name)
    if @med_repo.nil? || @med_repo.empty?
      initialize_med_repo
    end
    
    @med_repo[dd_name]
  end
  
  def self.find_by_patient_ien(ien)
    rpc = Vista::RPC.new("ORWPS ACTIVE", ien)  
    results = rpc.execute
    orders = com.medsphere.vistarpc.RPCArray.new
    order_id_to_dd = {}
    meds = []

    (0...results.size).each do |index|
      item = results[index]
      if(item.slice(0,1) == "~")
        parts = item.split(/\^/, 11)
        order_id = parts[8].split(";", 2)[0]
        dd_name = parts[2]
        if dd_name.index('[')
          dd_name = dd_name[0...dd_name.index('[')].strip
        end
        order_id_to_dd[order_id] = dd_name
        orders.put(index.to_s, "OR1:#{order_id}")
      end
    end

    if (orders.size > 0) 
      orders_rpc =Vista::RPC.new("ORRC ORDERS BY ID", orders)
      order_items = orders_rpc.execute
      (0...order_items.size).each do |oi|
        order_item = order_items[oi]
        if (order_item.match /^Item*/ )
          med = Medication.new
          parts = order_item.split(/\^/)
          id_parts = parts[0].split(":")
          med.order_id = id_parts[1]
          med.message = parts[1]
          #datePart = parts[2]               
          med.status = parts[3]
          dd_name = order_id_to_dd[med.order_id]
          med.name = dd_name
          med_info = find_med_info(dd_name)
          if med_info
            med.ndc = med_info[:ndc]
            med.generic_name = med_info[:generic_name]            
          end
          meds << med
        end
      end
    end
    meds
  end
  
  
end
