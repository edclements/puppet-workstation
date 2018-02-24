class workstation::users {

  file { '/home/ed':
    ensure => 'directory'
  }

  $groups = ['wheel', 'audio', 'power']

  group { $groups:
    ensure => 'present'
  }

  group { 'ed':
    ensure => 'present',
    gid => $uid
  }
  user { 'ed':
    ensure => 'present',
    shell => '/bin/bash',
    uid => $uid,
    gid => 'ed',
    groups => $groups,
    home => '/home/ed',
    managehome => true,
    require => [File['/home/ed'], Group[$groups]],
  }
  file { '/home/ed/src':
    ensure => 'directory',
    owner => 'ed',
    group => 'ed',
    require => File['/home/ed'],
  }

  exec {"check_ssh":
    command => '/bin/true',
    onlyif => '/usr/bin/test -e /home/ed/.ssh',
  }

  vcsrepo { '/home/ed/src/vimfiles':
    ensure => 'present',
    provider => 'git',
    owner => 'ed',
    group => 'ed',
    source => 'git@github.com:edclements/vimfiles.git',
    user => 'ed',
    require => Exec['check_ssh'],
  }

  file { '/home/ed/.vim':
    ensure => 'link',
    target => '/home/ed/src/vimfiles',
    force => true,
    owner => 'ed',
    group => 'ed',
    require => Vcsrepo['/home/ed/src/vimfiles'],
  }

  file { '/home/ed/.vimrc':
    ensure => 'link',
    target => '/home/ed/src/vimfiles/vimrc',
    owner => 'ed',
    group => 'ed',
    require => Vcsrepo['/home/ed/src/vimfiles'],
  }

  file { '/home/ed/.gitconfig':
    path => '/home/ed/.gitconfig',
    owner => 'ed',
    group => 'ed',
    content => template('workstation/gitconfig.erb'),
  }

  file { '/home/ed/.Xresources':
    path => '/home/ed/.Xresources',
    owner => 'ed',
    group => 'ed',
    source => 'puppet:///modules/workstation/Xresources.dark',
  }

  file { '/home/ed/.xinitrc':
    path => '/home/ed/.xinitrc',
    owner => 'ed',
    group => 'ed',
    source => 'puppet:///modules/workstation/xinitrc',
  }

  vcsrepo { '/home/ed/.fzf':
    ensure => 'present',
    provider => 'git',
    owner => 'ed',
    group => 'ed',
    source => 'https://github.com/junegunn/fzf.git',
    user => 'ed',
  } ->
  exec { '/home/ed/.fzf/install --key-bindings --completion --update-rc':
    cwd => '/home/ed',
    creates => '/home/ed/.fzf.bash',
  }

}
