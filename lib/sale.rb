module FarMar
  class Sale
    attr_reader :id, :amount, :vendor_id, :product_id, :purchase_time

    def initialize(sale_hash)
      @id = sale_hash[:id]
      @amount = sale_hash[:amount]
      @purchase_time = sale_hash[:purchase_time]
      @vendor_id = sale_hash[:vendor_id]
      @product_id = sale_hash[:product_id]
    end

    def self.read
      # IDEA make this an instance variable so you only have to make it run once
      sales = [] #array to store all of the hashes with sale info
      CSV.read("../FarMar/support/sales.csv").each do |line|
        sale = {id: line[0].to_i, amount: line[1].to_i, purchase_time: DateTime.parse(line[2]), vendor_id: line[3].to_i, product_id: line[4].to_i } #create a new hash for each sale to store specific info

        sales << self.new(sale) #creates a new instance with the hash info and puts it in the array to be returned
      end
      sales #returns this array
    end

    def self.all #what happens if the csv file is updated - this variable will not include new data
      @@all_sales ||= self.read
      return @@all_sales
    end

    def self.find(id)
      if FarMar::Sale.ids.include?(id)
        self.all.find { |s| s.id == id }
      else
        raise ArgumentError.new("There are no sales with that id")
      end
    end

    def vendor #returns the Vendor instance that is associated with this sale
      FarMar::Vendor.find(@vendor_id)
    end

    def product
      FarMar::Product.find(@product_id)
    end

    def self.between(beginning_time, end_time)
      self.all.select { |s| beginning_time <= s.purchase_time && s.purchase_time <= end_time }
    end

    def self.ids
      sale_ids = []

      self.all.each do |s|
        sale_ids << s.id
      end
      return sale_ids
    end
  end
end
