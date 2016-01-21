# == Class: gerrit::cron
#
class gerrit::cron {

  cron { 'gerrit_repack':
    user        => 'root',
    weekday     => '0',
    hour        => '4',
    minute      => '7',
    command     => 'find /home/gerrit2/review_site/git/ -type d -name "*.git" -print -exec git --git-dir="{}" repack -afd \;',
    environment => 'PATH=/usr/bin:/bin:/usr/sbin:/sbin',
  }

  cron { 'manage_project':
    user        => 'gerrit2',
    minute      => '*/30',
    command     => '/usr/local/bin/manage-projects -v >> /var/log/manage_projects.log 2>&1',
    require     => [Class['jeepyb'], File['/var/lib/jeepyb']],
  }

  cron { 'expireoldreviews':
    ensure      => 'absent',
    user        => 'gerrit2',
  }

  cron { 'removedbdumps':
    ensure      => 'absent',
    user        => 'gerrit2',
  }
}
