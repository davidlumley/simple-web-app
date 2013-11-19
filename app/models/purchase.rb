module SinatraApp
  class Purchase
    include DataMapper::Resource

    property :id,         Serial
    property :created_at, DateTime
    property :updated_at, DateTime

    property :quantity,   Integer, :required => true, :default => 1

    belongs_to :product
    belongs_to :user

    def subtotal
      self.total - self.tax
    end

    def total
      product.total * self.quantity
    end

    def tax
      product.tax * self.quantity
    end

  end
end