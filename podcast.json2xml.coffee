fs = require 'fs'
convert = require('data2xml')();

shows = require './'+process.argv[2]

title = "Above & Beyond: Group Therapy"
podcastUrl = "http://static.aboveandbeyond.nu/grouptherapy/podcast.xml"
author = "aboveandbeyond.nu"
link = "http://www.aboveandbeyond.nu/radio"
summary = "Group Therapy is the weekly radio show from Above & Beyond also known as ABGT"
language = "en"
name = "Above & Beyond"
copyright = "Above & Beyond"
email = "technical@aboveandbeyond.nu"
imageUrl = "http://tatw.co.uk/Group_Therapy_Podcast_600x600.jpg"
category = "Music"
keywords = ["abgt", "group therapy", "above & beyond", "above and beyond", "anjuna", "anjunabeats", "anjunadeep", "oceanlab", "tranquility base"]
explicit = "no"

podcast =
    _attr:
        "xmlns:itunes": "http://www.itunes.com/dtds/podcast-1.0.dtd"
        version: "2.0"
        "xmlns:atom": "http://www.w3.org/2005/Atom"
    channel:
	"itunes:new-feed-url": podcastUrl
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
        "itunes:category":
            _attr:
                text: category
        "itunes:keyword": keywords.join ","
        "itunes:explicit": explicit
        item:
            shows.map (show) ->
                show.enclosure =
                    _attr: show.enclosure
                return show

xmlPodcast = convert "rss", podcast

html = require 'html'

console.log html.prettyPrint xmlPodcast,
    indent_size: 2