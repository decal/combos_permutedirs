# Combinatorial Directory Pathname Permutations

* {Combinatorics::PermuteDirs}
* [Source](https://github.com/decal/combos_permutedirs)
* [Issues](https://github.com/decal/combos_permutedirs/issues)
* [Documentation](http://rubydoc.info/gems/combos_permutedirs)
* [Email](mailto:decal [AT] ethernet {D0T} org)

## Description

A collection of modules and methods for computing permutations
[Permutations](http://en.wikipedia.org/wiki/Permutations) on web-based and file
system paths and then testing for their existence. In other words, re-ordering
the directory names in the path. The purpose of this is to discover new paths
from known ones during the reconaissance phase of web application penetration 
testing or host security hardening of a workstation/server.

## Features

* Tests remote HTTP and HTTPS targets 
  * {Combinatorics::PermuteDirs::HTTP}
* Checks local filesystem if current user has permissions for subdirectories 
  * {Combinatorics::PermuteDirs::OSFS}

## Examples

Enumerate over every sub-range between two ranges:

    Combinatorics::PermuteDirs::OSFS.new('a/b/')
    # => ['a/b', 'b/a']

    include Combinatorics

    PermuteDirs::HTTP.new('http://www.google.com/app/cgi-bin/server-status.cgi').call

## Requirements

* [ruby](http://www.ruby-lang.org/) >= 2.2.2

## Install

    $ gem install combos_permutedirs

## Copyright

Copyright (c) 2015 Derek Callaway

See {file:LICENSE.txt} for license information.
