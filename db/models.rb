require 'sequel'

Sequel::Model.plugin(:schema)

DB = Sequel.connect('postgres://localhost/sliceworks')
