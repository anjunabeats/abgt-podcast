#!/usr/bin/env -c python

import sys, os, urllib, datetime, subprocess

# get lines from podcast info file
lines = [line.strip() for line in open(sys.argv[1], "r")]

filename = lines[0]
show_num = lines[1]
guest_mixer = lines[2]

# get http metadata from remote podcast file
podcast_url = 'http://traffic.libsyn.com/tatwpodcast/%s' % filename
meta = urllib.urlopen(podcast_url).info()

# get byte length of remote podcast file
length = meta.getheaders('Content-Length')[0]

guid = 'abgt%s' % show_num
author = "Above & Beyond"
title = "#%s Group Therapy Radio with Above & Beyond" % show_num
subtitle = "Episode #%s" % show_num

if guest_mixer:
    subtitle += " / Guest Mix: %s " % guest_mixer 

today = datetime.date.today()
friday = today + datetime.timedelta((4 - today.weekday()) % 7)

pubdate = '%s 21:10:00 +0100' % friday.strftime('%a, %d %b %Y')

duration = '02:00:00'
link = 'http://www.aboveandbeyond.nu/radio/abgt%s' % show_num
category = 'Music'

test= subprocess.check_output(['coffee', 'podcast.add.coffee',
                               '-i', 'shows.json',
                 '--guid', guid,
                 '--author', author,
                 '--title', title,
                 '--subtitle', subtitle,
                 '--pubdate', pubdate,
                 '--url', podcast_url,
                 '--length', length,
                 '--duration', duration,
                 '--link', link,
                 '--category', category])




print test
