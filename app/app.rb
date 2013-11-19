module SinatraApp
  class App < Sinatra::Base

    before do
      @current_product ||= Product.current
    end

    get '/' do
      erb :index
    end

    post '/purchase/?' do
      if @current_product.quantity >= params[:quantity].to_i

        @current_product.quantity -= params[:quantity].to_i
        @current_product.save

        user     = User.first_or_create(:email => params[:email])

        purchase          = user.purchases.new
        purchase.product  = @current_product
        purchase.quantity = params[:quantity].to_i
        purchase.save
      end
    end

  end
end