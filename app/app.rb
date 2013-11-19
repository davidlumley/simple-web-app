module SinatraApp
  class App < Sinatra::Base
    set :public_folder, File.join(Dir.pwd, 'public')
    before do
      @current_product ||= Product.current
    end

    get '/' do
      erb :index
    end

    post '/purchase/?' do
      token = params[:stripe_token]

      if @current_product.quantity >= 1

        user = User.first_or_create(:email => params[:email])

        begin
          charge = Stripe::Charge.create(
            :amount      => (@current_product.total * 100).to_i,
            :currency    => 'aud',
            :card        => token,
            :description => "#{@current_product.name} - #{user.email}"
          )
        rescue Stripe::CardError => e
          body = e.json_body
          err  = body[:error]
          redirect "/?error=#{err[:message]}"
        end

        @current_product.quantity -= 1
        @current_product.save

        purchase         = user.purchases.new
        purchase.product = @current_product

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