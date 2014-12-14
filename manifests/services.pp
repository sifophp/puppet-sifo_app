# Puppet manifest for an ALL-IN-ONE server (all services in the same machine)

# Useful packages.
$misc_packages = ['vim-enhanced','telnet','zip','unzip']
package { $misc_packages: ensure => latest }

# Clock
include '::ntp'

# Add entries in /etc/hosts:#
host { 'localhost.localdomain':
    ensure => 'present',
    target => '/etc/hosts',
    ip => '127.0.0.1',
    host_aliases => ['localhost','memcached','mysql']
}

# Firewall rules in modules/webserverfirewall/manifests/rules.pp:
include webserverfirewall


# Memcached server (128MB)
class { 'memcached':
    max_memory => 128,
    max_connections => 1024
}

# Apache
class { 'apache':
	default_mods        => false,
	default_confd_files => false,
}

# PHP
include php::mod_php5

# Needed modules
php::module { [ 'devel', 'pear', 'mysql', 'mbstring', 'xml', 'gd', 'pecl-apc', 'pecl-memcache' ]: }
php::module::ini { 'pecl-apc':
  settings => {
    'apc.enabled'      => '1',
    'apc.shm_segments' => '1',
    'apc.shm_size'     => '64',
  }
}

php::ini { '/etc/php.ini':
  display_errors => 'Off',
  memory_limit   => '128M',
}


