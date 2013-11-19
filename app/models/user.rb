module SinatraApp
  class User
    include DataMapper::Resource

    property :id,         Serial
    property :created_at, DateTime
    property :updated_at, DateTime

    property :email,      String,     :required => true, :unique => true, :index => true, :format => :email_address

    has n,   :purchases
  end
end