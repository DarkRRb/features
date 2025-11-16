. /etc/os-release

if [ "${ID}" != "alpine" ]; then
    echo "not supported os: ${ID:-unknown}" >&2
    exit 1
fi

sed -i "s#https\?://dl-cdn.alpinelinux.org/alpine#${SCHEME}://${HOST}${SPATH}#g" /etc/apk/repositories