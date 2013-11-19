module SinatraApp
  class App < Sinatra::Base

    before do
      @current_product ||= Product.current
    end

    get '/' do
      erb :index
    end

    post '/purchase/?' do
      if @current_product.quantity >= 1

        @current_product.quantity -= 1
        @current_product.save

        user     = User.first_or_create(:email => params[:email])

        purchase          = user.purchases.new
        purchase.product  = @current_product
        if purchase.save
          redirect '/success'
        else
          redirect '/failure'
        end
      end
    end

    get '/success' do
      erb :success
    end

    get '/failure' do
      erb :failure
    end

  end
end