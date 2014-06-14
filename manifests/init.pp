# = Class: lumenvox
#
# This is the main lumenvox class
#
# See README.md for details.
#
# == Author
#   Justin Aiken <jaiken@mojolingo.com>
#

class lumenvox (
  $username = $lumenvox::params::username,
  $password = $lumenvox::params::password,
  $override_options = {},
) inherits lumenvox::params
{

  $options = lumenvox_deepmerge($default_options, $override_options)

  include lumenvox::core
  include lumenvox::client
  include lumenvox::sre
  include lumenvox::media_server
  include lumenvox::tts
  include lumenvox::manager

  Class['lumenvox::core'] -> Class['lumenvox::client'] ->
  Class['lumenvox::sre']  -> Class['lumenvox::media_server'] ->
  Class['lumenvox::tts']  -> Class['lumenvox::manager']
}
