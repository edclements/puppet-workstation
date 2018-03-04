class workstation::packages {

  case $facts['os']['family'] {
    'Archlinux': {
      $packages = [
        'base-devel',
        'sudo',
        'git',
        'tmux',
        'gvim',
        'vifm',
        'tree',
        'rxvt-unicode',
        'x11-ssh-askpass',
        'unzip',
      ]
    }
    'Debian': {
      $packages = [
        'sudo',
        'git',
        'tmux',
        'gvim',
        'vifm',
        'tree',
        'chromium-browser',
        'rxvt-unicode',
        'cmake',
      ]
    }
  }

  package {
    $packages: ensure => 'installed',
  }

}
