class workstation::x11 {

  case $facts['os']['family'] {
    'Archlinux': {
      $xinitrc_source = 'puppet:///modules/workstation/xinitrc.dwm'
      $packages = [
        'xorg-server',
        'xorg-server-utils',
        'xorg-apps',
        'xorg-xinit',
        'xterm',
        'xorg-xfontsel',
        'ttf-droid',
        'ttf-dejavu',
        'ttf-bitstream-vera',
        'profont',
        'terminus-font',
        'ttf-anonymous-pro',
        'ttf-inconsolata',
        'nvidia',
        'nvidia-settings',
        'xf86-input-evdev', # fix mouse
      ];

      package { $packages: ensure => 'installed' }

      $xkb_layout = 'gb'

      file { 'keyboard':
        path => '/etc/X11/xorg.conf.d/00-keyboard.conf',
        content => template('workstation/keyboard.erb'),
      }

      file { '/etc/fonts/conf.d/10-sub-pixel-rgb.conf':
        ensure => 'link',
        target => '/etc/fonts/conf.avail/10-sub-pixel-rgb.conf',
      }

      file { 'nvidia':
        path => '/etc/X11/xorg.conf.d/20-nvidia.conf',
        source => 'puppet:///modules/workstation/nvidia',
      }

    }
    'Debian': {
      $xinitrc_source = 'puppet:///modules/workstation/xinitrc.gnome'
    }
  }

  file { '/home/ed/.Xresources':
    owner => 'ed',
    group => 'ed',
    source => 'puppet:///modules/workstation/Xresources',
  }

  file { '/home/ed/.Xresources.d':
    ensure => directory,
    owner => 'ed',
    group => 'ed',
  }

  file { '/home/ed/.Xresources.d/solarized':
    owner => 'ed',
    group => 'ed',
    source => 'puppet:///modules/workstation/Xresources.solarized.dark',
    require => File['/home/ed/.Xresources.d'],
  }

  file { '/home/ed/.xinitrc':
    owner => 'ed',
    group => 'ed',
    source => $xinitrc_source,
  }

}
