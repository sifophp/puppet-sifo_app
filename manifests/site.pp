# Puppet manifest for an ALL-IN-ONE server (all services in the same machine)

host { 'localhost.localdomain':
    ensure => 'present',
    target => '/etc/hosts',
    ip => '127.0.0.1',
    host_aliases => ['localhost','memcached','mysql']
}

# Memcached server (1GB)
class { 'memcached':
    max_memory => 1024,
    max_connections => 2048
}


