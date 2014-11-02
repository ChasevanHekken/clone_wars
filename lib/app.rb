
class SliceWorksApp < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/capitol-hill' do
    erb :caphill
  end

  get '/lodo' do
    erb :lodo
  end

  get '/menu' do
    erb :menu
  end

  get '/catering' do
    erb :catering
  end

  get '/locations' do
    erb :locations
  end

  get '/catering' do
    erb :catering
  end

  get '/gift-cards' do
    erb :gift_cards
  end

  get '/contact-us' do
    erb :contact_us
  end

  get '/dine_in' do
    erb :dine_in
  end

  get '/menucatering' do
    erb :menucatering
  end

end
