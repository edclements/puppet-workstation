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

  vcsrepo { '/home/ed/src/vimfiles':
    ensure => 'present',
    provider => 'git',
    owner => 'ed',
    group => 'ed',
    source => 'git@github.com:edclements/vimfiles.git',
    user => 'ed',
  }

  file { '/home/ed/.vim':
    ensure => 'link',
    target => '/home/ed/src/vimfiles',
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
    source => 'puppet:///modules/workstation/gitconfig',
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

  vcsrepo { '/home/ed/csound-instruments':
    ensure   => present,
    provider => git,
    source   => 'http://github.com/edclements/csound-instruments.git',
    force    => true,
  }

}
