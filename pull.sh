#!/bin/bash
while true; do
    curl "https://mediathekviewweb.de/feed?query=${QUERY}" -o /list.xml
    links=($(xmlstarlet sel -t -v "${XPATH}/@url" /list.xml))
    titles=($(xmlstarlet sel -n -t -v "${XPATH}/../pubDate" /list.xml | grep -o -P '(?<=, ).*(?= \d{2}:\d{2}:\d{2} GMT)' | sed -e 's/\s\+/-/g'))

    for ((i = 0; i < ${#titles[@]}; ++i)); do
        d=$(date -d "${titles[i]}" "+%Y-%m-%d")
        if [[ -f "${OUTPUT}/${d}.mp4" ]]; then
            echo "${titles[i]} exists. Skipping."
        else
            echo "Downloading ${titles[i]}."
            curl "${links[i]}" -o "${OUTPUT}/${d}.mp4"
        fi
    done

    sleep ${INTERVAL}
done
