#!/bin/sh
# Begin /usr/bin/pipewire-launcher.sh

# Kill PulseAudio too, and remove its socket, since it can grab the
# pulse socket before pipewire-pulse starts otherwise.
pulseaudio --kill 2>/dev/null
pkill -u "${USER}" -fx /usr/bin/pipewire-pulse
pkill -u "${USER}" -fx /usr/bin/wireplumber
pkill -u "${USER}" -fx /usr/bin/pipewire
rm -f "/run/user/$(id -u)/pulse/native"

sleep 1

# Start Pipewire first.
/usr/bin/pipewire &

# Wait until pipewire is actually up before starting wireplumber.
while [ -z "$(pgrep -x -u "${USER}" pipewire)" ]; do
    sleep 1
done

# Start Wireplumber now that Pipewire has been started.
/usr/bin/wireplumber &

# Start the Pulseaudio server included with Pipewire.
/usr/bin/pipewire-pulse &

# End /usr/bin/pipewire-launcher.sh
