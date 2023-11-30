#!/bin/bash
#
# required bash version 4 and above
#

uuid1=$(openssl rand -hex 16)
uuid2=$(openssl rand -hex 16)

ical_uid1=${uuid1:0:8}-${uuid1:8:4}-${uuid1:12:4}-${uuid1:16:4}-${uuid1:20:12}
ical_uid2=${uuid2:0:8}-${uuid2:8:4}-${uuid2:12:4}-${uuid2:16:4}-${uuid2:20:12}

CREATEDATE=`date -u +"%Y%m%dT%H%M%SZ"`
DTSTART=`date -d "+365 days" -u +"%Y%m%d"`
DTEND=`date -d "+366 days" -u +"%Y%m%d"`
SUMMARY="remind me to do something"
MYURL="https://sam.liho.tw"

tee "ical_reminder.ics" > /dev/null <<EOF
BEGIN:VCALENDAR
CALSCALE:GREGORIAN
PRODID:-//Apple Inc.//macOS 14.1.1//EN
VERSION:2.0
BEGIN:VEVENT
CREATED:$CREATEDATE
DTEND;VALUE=DATE:$DTEND
DTSTAMP:$CREATEDATE
DTSTART;VALUE=DATE:$DTSTART
LAST-MODIFIED:$CREATEDATE
SEQUENCE:0
SUMMARY:$SUMMARY
TRANSP:TRANSPARENT
UID:${ical_uid1^^}
URL;VALUE=URI:$MYURL
X-APPLE-CREATOR-IDENTITY:com.apple.calendar
X-APPLE-CREATOR-TEAM-IDENTITY:0000000000
BEGIN:VALARM
ACTION:DISPLAY
DESCRIPTION:Reminder
TRIGGER:-PT15H
UID:${ical_uid2^^}
X-APPLE-DEFAULT-ALARM:TRUE
X-WR-ALARMUID:${ical_uid1^^}
END:VALARM
END:VEVENT
END:VCALENDAR
EOF
