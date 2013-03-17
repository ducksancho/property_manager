# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
PropertyManager::Application.initialize!

::XERO_CONSUMER_KEY = "SAI6MR09GRIAAVD2TOYF5JFBA77TQI"
::XERO_CONSUMER_SECRET = "IUOBR3TR1UJBLWGVRLC45IKZCTKTUH"
::XERO_PRIVATE_KEY_PATH = "ssh/privatekey.pem"