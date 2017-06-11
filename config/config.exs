# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure for your application as:
#
#     config :tauth_proxy, key: :value
#
# And access this configuration in your application as:
#
#     Application.get_env(:tauth_proxy, :key)
#
# Or configure a 3rd-party app:
#
#     config :logger, level: :info
#

# Create an application at https://teller.io/developer/applications/new
  
config :tauth_proxy, application_id: "YOUR_APP_ID" 

# See https://teller.io/developer/documentation#section_tauth_access_permissions
# for a list of supported permissions

config :tauth_proxy, permissions: %{
  "full_account_number" => true,
  "balance" => true,
  "transaction_history" => true,
}

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env}.exs"
