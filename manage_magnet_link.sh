gconftool-2 -t string -s /desktop/gnome/url-handlers/magnet/command "/usr/bin/transmission %s"
gconftool-2 -s /desktop/gnome/url-handlers/magnet/needs_terminal false -t bool
gconftool-2 -t bool -s /desktop/gnome/url-handlers/magnet/enabled true
