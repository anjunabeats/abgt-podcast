fs = require 'fs'
convert = require('data2xml')();
shows = require './'+process.argv[2]

title = "Above & Beyond: Group Therapy"
podcastUrl = "http://tatw.co.uk/podcast.xml"
author = "aboveandbeyond.nu"
link = "http://www.aboveandbeyond.nu/radio"
summary = "salut"
language = "en"
name = "Above & Beyond"
copyright = "Above & Beyond"
email = "technical@aboveandbeyond.nu"
imageUrl = "http://tatw.co.uk/Group_Therapy_Podcast_600x600.jpg"
category = "Music"
keywords = ["group therapy", "above & beyond", "above and beyond", "anjuna", "anjunabeats", "anjunadeep", "oceanlab", "tranquility base"]
explicit = "no"

podcast =
    _attr:
        "xmlns:itunes": "http://www.itunes.com/dtds/podcast-1.0.dtd"
        version: "2.0"
        "xmlns:atom": "http://www.w3.org/2005/Atom"
    channel:
        "atom:link":
            _attr:
                rel: "self"
                href: podcastUrl
                type: "application/rss+xml"
        lastBuildDate: 0
        title: title
        "itunes:author": author
        link: link
        "itunes:subtitle": null
        "itunes:summary": summary
        language: language
        copyright: copyright
        "itunes:owner":
            "itunes:name": name
            "itunes:email": email
        "itunes:image":
            _attr:
                href: imageUrl
        "itunes:link":
            _attr:
                rel: "image"
                type: "video/jpeg"
                href: imageUrl
            _value: title
        category: category
        "itunes:category": category
        "itunes:keyword": keywords.join ","
        "itunes:explicit": explicit
        item:
            shows.map (show) ->
                show.enclosure =
                    _attr: show.enclosure
                return show

xmlPodcast = convert "rss", podcast

console.log xmlPodcast