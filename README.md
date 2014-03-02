#Simple SSH Key

A simple module to manage ssh keys (and related files) from puppet.

##Usage:
```puppet
simple_ssh_key { "thomas":
  private_key     => "puppet:///modules/users/thomas/private.key",
  public_key      => "puppet:///modules/users/thomas/public.key",
  home_dir        => "/home/thomas",
  known_hosts     => "puppet:///modules/users/thomas/known_hosts.txt",
  authorized_keys => "puppet:///modules/users/thomas/authorized_keys.txt"
}
```

Normally, *home_dir* would not need to be specific.
