module SinatraApp
  class Product
    include DataMapper::Resource

    property :id,         Serial
    property :created_at, DateTime
    property :updated_at, DateTime

    property :name,       String,  :required => true
    property :total,      Decimal, :precision => 10, :scale => 2
    property :quantity,   Integer, :required => true, :default => 50

    def self.current
      self.first(:quantity.gt => 0)
    end

    def sub_total
      self.total - self.tax
    end

    def tax
      self.total / 11
    end
  end
end