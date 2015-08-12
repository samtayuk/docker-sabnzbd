#! /bin/sh
set -e

echo checking sabnzbd.ini
if [ ! -f /config/sabnzbd.ini ]; then
    echo "sabnzbd.ini doesn't exist. creating default sabnzbd.ini"
    echo "__version__ = 19
[misc]
download_dir = /data/downloads/incomplete
complete_dir = /data/downloads/complete
permissions = 777
api_key = $API_KEY
[categories]
[[*]]
priority = 0
pp = 3
name = *
script = Default
newzbin = ""
dir = others
[[films]]
priority = -100
pp = ""
name = films
script = Default
newzbin = ""
dir = films
[[shows]]
priority = -100
pp = ""
name = shows
script = Default
newzbin = ""
dir = others
[[music]]
priority = -100
pp = ""
name = music
script = Default
newzbin = ""
dir = music
[[software]]
priority = -100
pp = ""
name = software
script = Default
newzbin = ""
dir = software" > /config/sabnzbd.ini
    echo "API Key: $API_KEY"
fi

exec "$@"
