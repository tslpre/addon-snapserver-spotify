#!/usr/bin/env bashio

mkdir -p /share/snapfifo
mkdir -p /share/snapcast

config=/etc/snapserver.conf

if ! bashio::fs.file_exists '/etc/snapserver.conf'; then
    touch /etc/snapserver.conf ||
        bashio::exit.nok "Could not create snapserver.conf file on filesystem"
fi
bashio::log.info "Populating snapserver.conf..."

# Server Config
echo "[server]" > "${config}"

# Threads
threads=$(bashio::config 'server_threads')
echo "threads = ${threads}" >> "${config}"

# Datadir
datadir=$(bashio::config 'server_datadir')
echo "datadir = ${datadir}" >> "${config}"

# Stream Config
echo "[stream]" >> "${config}"

# Spotify
spotify_stream=$(bashio::config 'spotify_stream')
echo -n "${spotify_stream}" >> "${config}"

spotify_username=$(bashio::config 'spotify_username')
echo -n "&username=${spotify_username}" >> "${config}"
spotify_password=$(bashio::config 'spotify_password')
echo -n "&password=${spotify_password}" >> "${config}"
spotify_device_name=$(bashio::config 'spotify_device_name')
echo -n "&devicename=${spotify_device_name}" >> "${config}"
spotify_bitrate=$(bashio::config 'spotify_bitrate')
echo -n "&bitrate=${spotify_bitrate}" >> "${config}"
spotify_volume=$(bashio::config 'spotify_volume')
echo -n "&volume=${spotify_volume}" >> "${config}"

echo "" >> "${config}"

# Other streams
if bashio::config.has_value 'streams'; then
    streams=$(bashio::config 'streams')
    echo "${streams}" >> "${config}"
fi

# Stream bis and ter
if bashio::config.has_value 'stream_bis'; then
    stream_bis=$(bashio::config 'stream_bis')
    echo "${stream_bis}" >> "${config}"
fi
if bashio::config.has_value 'stream_ter'; then
    stream_ter=$(bashio::config 'stream_ter')
    echo "${stream_ter}" >> "${config}"
fi

# Buffer
buffer=$(bashio::config 'buffer')
echo "buffer = ${buffer}" >> "${config}"

# Codec
codec=$(bashio::config 'codec')
echo "codec = ${codec}" >> "${config}"

# Muted
muted=$(bashio::config 'send_to_muted')
echo "send_to_muted = ${muted}" >> "${config}"

# Sampleformat
sampleformat=$(bashio::config 'sampleformat')
echo "sampleformat = ${sampleformat}" >> "${config}"

# HTTP
http=$(bashio::config 'http_enabled')
echo "[http]" >> "${config}"
echo "enabled = ${http}" >> "${config}"
echo "bind_to_address = ::" >> "${config}"

# HTTP document root
http_doc_root=$(bashio::config 'http_doc_root')
echo "doc_root = ${http_doc_root}" >> "${config}"

# TCP
echo "[tcp]" >> "${config}"
tcp=$(bashio::config 'tcp_enabled')
echo "enabled = ${tcp}" >> "${config}"

# Logging
echo "[logging]" >> "${config}"
logging=$(bashio::config 'logging_enabled')
echo "debug = ${logging}" >> "${config}"

bashio::log.info "Starting SnapServer..."

/usr/bin/snapserver -c /etc/snapserver.conf
