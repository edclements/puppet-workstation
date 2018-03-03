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

}
