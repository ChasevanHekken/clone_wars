class Config

  configure :developement do
    DB = Sequel.connect('postgres://localhost/sliceworks')
  end

  configure :production do
    DB = Sequel.connect(ENV['DATABASE_URL'])
  end

end
