# Virtual hosts
include apache
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
