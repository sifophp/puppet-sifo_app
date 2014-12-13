#!/bin/bash
# Puppet modules needed for a "puppet apply" standalone installation

puppet module install puppetlabs-firewall --version 1.2
puppet module install puppetlabs-apache --version 1.2
puppet module install puppetlabs-mysql --version 3.0.0
puppet module install puppetlabs-ntp --version 3.3.0
puppet module install saz-memcached --version 2.6.0
puppet module install thias-php --version 1.0.0
puppet module install puppetlabs-vcsrepo --version 1.2.0
puppet module install tPl0ch-composer --version 1.3.3
