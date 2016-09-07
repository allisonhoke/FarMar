module FarMar
  class Sale
    attr_reader :id, :amount, :vendor_id

    def initialize(sale_hash)
      @id = sale_hash[:id]
      @amount = sale_hash[:amount]
      @purchase_time = sale_hash[:purchase_time]
      @vendor_id = sale_hash[:vendor_id]
      @product_id = sale_hash[:product_id]
    end

# TO DO - figure out how to convert purchase_time to datetime data type
    def self.all
      sales = [] #array to store all of the hashes with sale info
      CSV.read("../FarMar/support/sales.csv").each do |line|
        sale = {id: line[0].to_i, amount: line[1].to_i, purchase_time: line[2], vendor_id: line[3].to_i, product_id: line[4].to_i } #create a new hash for each sale to store specific info

        sales << self.new(sale) #creates a new instance with the hash info and puts it in the array to be returned
      end
      sales #returns this array
    end

    def self.find(id)
      self.all.each do |s|
        if s.id == id
          return s #returns the object whose id matches the argument
        end
      end
    end

  end
end