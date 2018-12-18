# Example Puppet class!
#
# Chassis automatically loads your class, and passes $config in, which is an
# array representing the YAML-based configuration. You can use this to access
# Chassis configuration, or your own custom keys. In this demo, we've used
# `show_example`. To test it out, add the following to your config:
#
#     show_example: hello!
#
# The entirety of your behaviour should be wrapped inside this class.
#
# ***********************************
#          IMPORTANT NOTES:
#
# * Your module directory must be named the same as the extension.
# * Your class must be in init.pp, and named the same as the extension.
#
# ***********************************

class chassis-wxr (
  $config
) {
  if $config[wxr] {
    # TODO: Should we support absolute paths?
    $wxr_path = "${ $config[mapped_paths][content] }/${ $config[wxr][path] }"

    # TODO: Reinstate some sort of error notification.
    # exec { "check_wxr_exists":
    # 	command => "/bin/true",
    # 	onlyif  => "/usr/bin/test -e ${ $wxr_path }",
    # }

    if $config[wxr][clean] == true {
      wp::command { "$location wp site empty":
        location => $config[mapped_paths][base],
        command  => 'site empty --uploads --yes',
        # These tasks will not run unless WP is installed.
        require  => Chassis::Wp[ $config['hosts'][0] ],
      }

      -> wp::plugin { 'wordpress-importer':
        ensure   => installed,
        location => $config[mapped_paths][base],
        require  => Class['wp'],
      }

      -> wp::command { "$location wp import ${ $wxr_path }":
        location => $config[mapped_paths][base],
        command  => "import ${ $wxr_path } --authors=create",
      }
    }
    else {
      wp::plugin { 'wordpress-importer':
        ensure   => installed,
        location => $config[mapped_paths][base],
        # These tasks will not run unless WP is installed.
        require  => Chassis::Wp[ $config['hosts'][0] ],
      }

      -> wp::plugin { 'wordpress-importer':
        ensure   => enabled,
        location => $config[mapped_paths][base],
      }

      -> wp::command { "$location wp import ${ $wxr_path }":
        location => $config[mapped_paths][base],
        command  => "import ${ $wxr_path } --authors=create",
      }
    }
  }
}
