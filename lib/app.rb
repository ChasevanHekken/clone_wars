require_relative 'contact'
require_relative 'contact_store'
require_relative 'category_store'
require_relative '../db/models'

class SliceWorksApp < Sinatra::Base

  configure :developement do
    DB
  end

  configure :production do
    DB = Sequel.connect(ENV['DATABASE_URL'])
  end

  def protected!
    return if authorized?
    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, "Not authorized\n"
  end

  def authorized?
    @auth ||= Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? &&
    @auth.credentials && @auth.credentials == ['admin', 'admin']
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
    @categories = CategoryStore.add_catering_items_to_categories

    # @categories.each do |category|
    #   puts "heres category #{category[:name]}"
    #
    #   puts "here are the items: #{DB.from(:catering_items).where(:category_id => category[:id]).to_a}"
    # end
    # @categories = {
    #   pizza: [
    #     {name: 'Cheese', full_price: 10, half_price: 5},
    #     {name: 'Chicken', ingredients:'chicken and buffalo sauce', full_price: 15, half_price: 9},
    #     {name: 'Greek', ingredients:'pesto, basil, feta', full_price: 15, half_price: 9}
    #   ]
    # }


    # protected!

    erb :menu_catering
  end

  get '/happy-hour' do
    erb :happy_hour
  end

  post '/contact-us/' do
    p params
    name = params[:name]
    email = params[:email]
    subject = params[:subject]
    message = params[:message]

    Pony.mail(:to => "zrouthier@gmail.com", :from => "#{email}", :subject => "subject from #{name}", :body => "#{message}")

    redirect '/contact-us'
  end

  post '/menu_catering' do
    params[:item]
  end
end
  # delete '/:id' do |id|
  #   ContactStore.delete(id.to_i)
  # end

  # get '/:id/edit' do |id|
  #   contact = ContactStore.find(id.to_i)
  #   erb :edit, locals: {contact: contact}
  # end
