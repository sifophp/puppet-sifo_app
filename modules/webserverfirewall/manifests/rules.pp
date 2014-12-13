class webserverfirewall::rules {
    # Non-default rules go here
    firewall { "010 http on port 80":
         proto => "tcp",
         dport => "80",
         action => "accept",
    }

    firewall { "020 ssh on port 22":
         proto => "tcp",
         dport => "22",
         action => "accept",
    }
}
