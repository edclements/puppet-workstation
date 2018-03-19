class workstation::audio {

  $packages = [
    'alsa-utils',
    'pulseaudio',
    'pulseaudio-alsa',
    'pavucontrol',
    'paprefs',
    'jack2',
    'pulseaudio-jack',
    'cadence',
    'csound',
    'a2jmidid',
  ]

  package { $packages: ensure => 'installed' }

  file { '/etc/modprobe.d/snd-virmidi.conf':
    path => '/etc/modprobe.d/snd-virmidi.conf',
    source => 'puppet:///modules/workstation/audio/snd-virmidi.conf',
  }

}
