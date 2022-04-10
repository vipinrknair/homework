# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# third-party users, it should be done in your "mix.exs" file.

config :hound, driver: "chrome_driver",
  login_url: "https://the-internet.herokuapp.com/login",
  login_form_user_api: "https://reqres.in/api/users/2",
  valid_username: "tomsmith",
  valid_pwd: "SuperSecretPassword!",
  sorttable_url: "https://the-internet.herokuapp.com/tables",
  table_value1: "//body[1]/div[2]/div[1]/div[1]/table[1]/tbody[1]/tr[1]/td[4]",
  table_value2: "//body[1]/div[2]/div[1]/div[1]/table[1]/tbody[1]/tr[2]/td[4]",
  table_value3: "//body[1]/div[2]/div[1]/div[1]/table[1]/tbody[1]/tr[3]/td[4]",
  table_value4: "//body[1]/div[2]/div[1]/div[1]/table[1]/tbody[1]/tr[4]/td[4]",
  due_amount: "#table1 thead tr th:nth-of-type(4)",
  iframe_url: "https://the-internet.herokuapp.com/iframe",
  iframe_id: "mce_0_ifr",
  iframe_body: "//body//p",
  iframe_text: "Vipin is learning Elixir"

# You can configure your application as:
#
#     config :homework, key: :value
#
# and access this configuration in your application as:
#
#     Application.get_env(:homework, :key)
#
# You can also configure a third-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env()}.exs"
