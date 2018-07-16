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
		$wxr_path = "${ $config[mapped_paths][content] }/${ $config[wxr][path] }"

		exec { "check_wxr_exists":
			command => "/bin/true",
			onlyif  => "/usr/bin/test -e ${ $wxr_path }",
		}

		# notify { 'WXR file missing! No file exists at ${ $wxr_path }':
		# 	require => Exec["check_wxr_exists"]
		# }

		wp::plugin { 'wordpress-importer':
			location => $config[mapped_paths][base],
			ensure   => installed,
			require  => [
				Class['wp'],
				Exec["check_wxr_exists"],
			],
		}

		-> wp::command { "$location wp import ${ $wxr_path }":
			location => $config[mapped_paths][base],
			command => "import ${ $wxr_path } --authors=create",
		}
	}
}
