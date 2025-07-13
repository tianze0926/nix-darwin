# https://superuser.com/a/1819754
{ ... }:
{
  homebrew.brews = [
    {
      name = "sleepwatcher";
      start_service = true;
    }
    "blueutil"
  ];
  hm = [
    (
      { ... }:
      {
        home.file.".sleep".text = ''
          #!/bin/bash
          /opt/homebrew/bin/blueutil --power off
          logger "$(date -Iseconds) -- Sleep event detected, bluetooth disabled. Bluetooth status: $(/opt/homebrew/bin/blueutil --power)"
        '';
        home.file.".wakeup".text = ''
          #!/bin/bash
          /opt/homebrew/bin/blueutil --power on
          logger "$(date -Iseconds) -- Wake event detected, bluetooth enabled. Bluetooth status: $(/opt/homebrew/bin/blueutil --power)"
        '';
      }
    )
  ];
}
