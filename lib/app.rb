require_relative 'contact'
require_relative 'contact_store'
require_relative 'category_store'

class SliceWorksApp < Sinatra::Base

    db_url = ENV["RACK_ENV"] == "production" ? ENV['DATABASE_URL'] : 'postgres://localhost/sliceworks'
    DB = Sequel.connect(db_url)

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
    # settings.database

    @categories = CategoryStore.add_catering_items_to_categories

    # protected!

    erb :menu_catering
  end

  post '/form_input' do

    category    = params[:category]
    item_name   = params[:item_name]
    half_price  = params[:half_price]
    full_price  = params[:full_price]
    description = params[:description]

    CategoryStore.add_catering_item(category, item_name, half_price, full_price, description)

    redirect '/menu-catering'
  end

  get '/happy-hour' do
    erb :happy_hour
  end

  post '/contact-us/' do
    name    = params[:name]
    email   = params[:email]
    subject = params[:subject]
    message = params[:message]

    Pony.mail(:to => "zrouthier@gmail.com", :from => "#{email}", :subject => "subject from #{name}", :body => "#{message}")

    redirect '/contact-us'
  end

  post '/menu_catering' do
    params[:item]
  end
end
