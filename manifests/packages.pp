class workstation::packages {

  $packages = [
    'sudo',
    'git',
    'vim',
    'tmux',
    'vifm',
    'tree',
    'chromium-browser',
    'csound',
    'rxvt-unicode',
    'jack',
    'cmake',
  ]

  package {
    $packages: ensure => 'installed',
  }

  vcsrepo { '/home/ed/.vim':
    ensure   => present,
    provider => git,
    source   => 'http://github.com/edclements/vimfiles.git',
    force    => true,
  }

  vcsrepo { '/home/ed/csound-instruments':
    ensure   => present,
    provider => git,
    source   => 'http://github.com/edclements/csound-instruments.git',
    force    => true,
  }

}
