#!/bin/bash
#
# if you run this script on macOS you need to use "date -v" instead of "date -d"
#

rawurlencode() {
    local string="${1}"
    local strlen=${#string}
    local encoded=""
    local pos c o

    for (( pos=0 ; pos<strlen ; pos++ )); do
        c=${string:$pos:1}
        case "$c" in
            [-_.~a-zA-Z0-9] ) o="${c}" ;;
            * )               printf -v o '%%%02x' "'$c"
        esac
        encoded+="${o}"
    done
    echo "${encoded}"    # You can either set a return variable (FASTER)
    REPLY="${encoded}"   #+or echo the result (EASIER)... or both... :p
}

CREATEDATE=`date -u +"%Y%m%dT%H%M%SZ"`
DTSTART=`date -d "+365 days" -u +"%Y%m%d"`
# DTSTART=`date -v +365d -u +"%Y%m%d"`
DTEND=`date -d "+366 days" -u +"%Y%m%d"`
# DTEND=`date -v +366d -u +"%Y%m%d"`
SUMMARY="remind me to do something"
GCAL_URL_BASE="https://calendar.google.com/calendar/u/0/r/eventedit?"
MYURL="https://sam.liho.tw"
MYURL_HTML="<a href=\"https://sam.liho.tw\">https://sam.liho.tw</a>"
GCAL_URL=$GCAL_URL_BASE"text="$(rawurlencode "$SUMMARY")"&dates="$DTSTART"/"$DTEND"&details="$(rawurlencode "$MYURL_HTML")"&location="$MYURL
