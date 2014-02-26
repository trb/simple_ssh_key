define simple_ssh_key ($user = $name, $private_key, $public_key, $home_dir = "", $known_hosts = "") {
  if ($home_dir == "") {
    $home_dir_path = "/home/$user"
  } else {
    $home_dir_path = $home_dir
  }

  file { "$home_dir_path/.ssh":
    ensure => directory,
    mode   => "0700"
  }

  file { "$home_dir_path/.ssh/id_rsa":
    ensure  => present,
    owner   => $user,
    group   => $user,
    mode    => "0600",
    source => $private_key,
    require => File["$home_dir_path/.ssh"]
  }

  file { "$home_dir_path/.ssh/id_rsa.pub":
    ensure  => present,
    owner   => $user,
    group   => $user,
    mode    => "0600",
    source => $public_key,
    require => File["$home_dir_path/.ssh"]
  }

  if ($known_hosts != "") {
    file { "$home_dir_path/.ssh/known_hosts":
      ensure  => present,
      owner   => $user,
      group   => $user,
      mode    => "0600",
      source => $known_hosts,
      require => File["$home_dir_path/.ssh"]
    }
  }
  # can't use file_line to manage authorized_keys because
  # the "line" would be the public key, which needs to be
  # read from the file which is given in puppet:/// notation
  # and file() can't handle that
}
