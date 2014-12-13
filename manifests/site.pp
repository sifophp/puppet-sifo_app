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


# Virtual hosts
apache::vhost { 'sifo.me':
    priority        => '0010',
    port            => '80',
    docroot         => '/var/www/sifo.me/instances/sifoweb/public/root',
    # conf_template		=> '/etc/puppet/files/templates/vhost-sifo.conf.erb',
#    # serveraliases   => ['sifo.me','en.sifo.me', 'ca.sifo.me' ],
#    # require         => Class['sifo::instances']
}

# Install composer dependency manager
include composer

composer::exec { 'sifo-install':
    cmd                  => 'install',  # REQUIRED
    cwd                  => '/var/www/sifo.me', # REQUIRED
    prefer_source        => false,
    prefer_dist          => false,
    dry_run              => false, # Just simulate actions
    custom_installers    => false, # No custom installers
    scripts              => false, # No script execution
    interaction          => false, # No interactive questions
    optimize             => false, # Optimize autoloader
    dev                  => true, # Install dev dependencies
    onlyif               => undef, # If true
    unless               => undef, # If true
}

# Install the http://sifo.me site:
vcsrepo { "/var/www/sifo.me":
    	ensure => present,
    	provider => git,
    	source => "https://github.com/sifophp/sifo-app.git",
    	revision => 'master'
    }


# include php::cli # Installed by composer
include php::mod_php5
php::module { [ 'devel', 'pear', 'mysql', 'mbstring', 'xml', 'gd', 'tidy', 'pecl-apc', 'pecl-memcache' ]: }

php::ini { '/etc/php.ini':
  display_errors => 'Off',
  memory_limit   => '128M',
}


