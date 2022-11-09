# Jekyll plugin for generating Git hash
#
# Place this file in the _plugins directory and
# use {{ site.data['hash'] }} in your Liquid templates
#
# Author: Yegor Bugayenko <yegor@tpc2.com>
# Source: http://github.com/yegor256/jekyll-git-hash
#
# Distributed under the MIT license
# Copyright Yegor Bugayenko, 2014

module Jekyll
    class GitHashGenerator < Generator
        priority :high
        safe true
        def generate(site)
            timestamp = %x( date +"%Y-%m-%d %H:%M" ).strip
            site.data['build-timestamp'] = timestamp
        end
    end
end
