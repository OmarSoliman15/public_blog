# Creating database context
db_config_file = File.join(File.dirname(__FILE__), '..', 'app', 'database.yml')
if File.exist?(db_config_file)
  config = YAML.load(File.read(db_config_file))
  DB = Sequel.connect(config)
  Sequel.extension :migration
end

Dir[File.join(File.dirname(__FILE__), '..', 'lib', '*.rb')].each {|file| require file }
Dir[File.join(File.dirname(__FILE__), '..', 'app', '**', '*.rb')].each {|file| require file }
if DB
  Sequel::Migrator.run(DB, File.join(File.dirname(__FILE__), '..', 'app', 'db', 'migrations'))
end

ROUTES = YAML.load(File.read(File.join(File.dirname(__FILE__), '..', 'app', 'routes.yml')))
