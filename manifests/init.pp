define simple_ssh_key ($user = $name, $private_key, $public_key, $home_dir = "", $known_hosts = "", $authorized_keys = "") {
  if ($home_dir == "") {
    $home_dir_path = "/home/$user"
  } else {
    $home_dir_path = $home_dir
  }

  file { "$home_dir_path/.ssh":
    ensure => directory,
    owner  => $user,
    group  => $user,
    mode   => "0700"
  }

  file { "$home_dir_path/.ssh/id_rsa":
    ensure  => present,
    owner   => $user,
    group   => $user,
    mode    => "0600",
    source  => $private_key,
    require => File["$home_dir_path/.ssh"]
  }

  file { "$home_dir_path/.ssh/id_rsa.pub":
    ensure  => present,
    owner   => $user,
    group   => $user,
    mode    => "0600",
    source  => $public_key,
    require => File["$home_dir_path/.ssh"]
  }

  if ($known_hosts != "") {
    file { "$home_dir_path/.ssh/known_hosts":
      ensure  => present,
      owner   => $user,
      group   => $user,
      mode    => "0600",
      source  => $known_hosts,
      require => File["$home_dir_path/.ssh"]
    }
  }

  if ($authorized_keys != "") {
    file { "$home_dir_path/.ssh/authorized_keys":
      ensure  => present,
      owner   => $user,
      group   => $user,
      mode    => "0600",
      source  => $authorized_keys,
      require => File["$home_dir_path/.ssh"]
    }
  }
}
