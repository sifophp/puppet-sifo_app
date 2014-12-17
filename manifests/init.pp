class sifo_app {
	# Puppet manifest for an ALL-IN-ONE server (all services in the same machine)

	# Useful packages.
	$misc_packages = ['vim-enhanced','telnet','zip','unzip']
	package { $misc_packages: ensure => latest }

	# Clock
	include '::ntp'
}