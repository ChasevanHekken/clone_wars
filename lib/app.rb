require_relative 'contact'
require_relative 'contact_store'

class SliceWorksApp < Sinatra::Base

  configure :developement do
    DB = Sequel.connect('postgres://localhost/sliceworks')
  end

  configure :production do
    DB = Sequel.connect(ENV['DATABASE_URL'])
  end

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

  get '/dine-in' do
    erb :dine_in
  end

  get '/menu-catering' do
    erb :menu_catering
  end

  get '/happy-hour' do
    erb :happy_hour
  end

  post '/contact-us/' do
    ContactStore.create(params[:contact])
    redirect '/contact-us'
  end

  # delete '/:id' do |id|
  #   ContactStore.delete(id.to_i)
  # end

  # get '/:id/edit' do |id|
  #   contact = ContactStore.find(id.to_i)
  #   erb :edit, locals: {contact: contact}
  # end

end
