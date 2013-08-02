#!/usr/bin/env -c python

import sys, os, urllib, datetime, subprocess
from optparse import OptionParser

parser = OptionParser()
parser.add_option('-f', '--filename', dest='filename',
                  help='ABGT podcast url', action='store')
parser.add_option('-n', '--num', dest='show_num',
                  help='ABGT number', action='store')
parser.add_option('-g', '--guest', dest='guest_mixer',
                  help='ABGT guest mixer', action='store')

(options, args) = parser.parse_args()

if options.filename is None or \
        options.show_num is None or \
        options.guest_mixer is None :
    parser.error('Missing arguments')
    
# get http metadata from remote podcast file
podcast_url = 'http://traffic.libsyn.com/tatwpodcast/%s' % options.filename
meta = urllib.urlopen(podcast_url).info()

# get byte length of remote podcast file
length = meta.getheaders('Content-Length')[0]

guid = 'abgt%s' % options.show_num
author = "Above & Beyond"
title = "#%s Group Therapy Radio with Above & Beyond" % options.show_num
subtitle = "Episode #%s / Guest Mix: %s" % (options.show_num, options.guest_mixer)

today = datetime.date.today()
friday = today + datetime.timedelta((4 - today.weekday()) % 7)

pubdate = '%s 21:10:00 +0100' % friday.strftime('%a, %d %b %Y')

duration = '02:00:00'
link = 'http://www.aboveandbeyond.nu/radio/abgt%s' % options.show_num
category = 'Music'

test= subprocess.call(['coffee', 'podcast.add.coffee',
                               '-i', 'shows.json',
                       '--guid', guid,
                       '--author', author,
                       '--title', title,
                       '--subtitle', subtitle,
                       '--description', subtitle,
                       '--pubdate', pubdate,
                       '--url', podcast_url,
                       '--length', length,
                       '--duration', duration,
                       '--link', link,
                       '--category', category])


print test
