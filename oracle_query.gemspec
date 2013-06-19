Gem::Specification.new do |s|
  s.name      = 'oracle_query'
  s.version   = '0.1.6'
  s.date      = '2013-06-19'
  s.summary   = 'Oracle Query!'
  s.description = 'A way to neatly query Oracle with Ruby'
  s.authors     = ['Steven Arsena']
  s.email       = 'sjarsena@gmail.com'
  s.files       = ["lib/oracle_query.rb"]
  s.homepage    = 'http://rubygems.org/gems/oracle_query'

  #Dependencies
  s.add_dependency "ruby-oci8", ">= 2.1.3"
end