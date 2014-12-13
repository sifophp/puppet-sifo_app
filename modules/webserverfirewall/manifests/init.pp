class webserverfirewall
{
    exec { 'clear-firewall':
      command => '/sbin/iptables -F',
      refreshonly => true,
    }

    exec { 'persist-firewall':
      command => '/sbin/iptables-save >/etc/sysconfig/iptables',
      refreshonly => true,
    }


    resources { "firewall":
      purge => true
    }

    Firewall {
      before  => Class['webserverfirewall::post'],
      require => Class['webserverfirewall::pre'],

      subscribe => Exec['clear-firewall'],
      notify  => Exec["persist-firewall"],
      #require => Exec["purge default firewall"],
    }

    class { ['webserverfirewall::pre', 'webserverfirewall::rules','webserverfirewall::post']: }
    class { 'firewall': }
}