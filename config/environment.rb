# Load the rails application
require File.expand_path('../application', __FILE__)
CFG=YAML::load_file("#{Rails.root.to_s}/config/sys.yml")
Rails.env=CFG['env']

# Initialize the rails application
Tipegoo::Application.initialize!
