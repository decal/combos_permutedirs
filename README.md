# Combinatorial Permutation of Directories

* {Combinatorics::PermuteDirs}
* [Source](https://github.com/decal/combos_permutedirs)
* [Issues](https://github.com/decal/combos_permutedirs/issues)
* [Documentation](http://rubydoc.info/gems/combos_permutedirs)
* [Email](mailto:decal [AT] ethernet {D0T} org)

## Description

Ever been determined to discover new sub-directories that may exist during a
web application penetration test? This toolset may help in such a situation.  
It creates entirely new fully qualified URL's or local filesystem pathnames 
entirely based on the pre-existing names used by directories which have already
been discovered. Simply provide the output from programs like dirb, DirBuster, 
dirbx, and others as input to the provided Ruby script executables.

In essence, this is a collection of modules, methods and scripts for computing 
all [Permutations](http://en.wikipedia.org/wiki/Permutations) within the
[Power Set](https://en.wikipedia.org/wiki/Power_set) of a given file/URI path's
directory names. Thereafter, their existence may be tested for whether they be
web-based or local file system paths. You may use these scripts themselves to 
check for their existence or have them create output files to be used as input
for another brute-force search or enumeration type scanning tool. In plainer 
terms, all orders of directory names as well as variations of full path length 
are computed. The purpose of this is to discover new paths from known ones 
during reconaissance for web application penetration testing or the host-based
security hardening of a workstation/server image.

## Features

* Tests remote HTTP and HTTPS targets 
  * {URI::HTTP}
  * {URI::HTTPS}
* Facilitates extension to other URI schemes
  * {Combinatorics::PermuteDirs::Mixin}
* Checks local filesystem to validate current user's permission to access paths
  * {Combinatorics::PermuteDirs::Local}

## Examples

Enumerate over every sub-range between two ranges:

> URI('https://host.dom/cgi-bin/test/').permute_dirs{|x| x.each{|y| puts "/#{y.to_a.join('/')}"}}
/
/cgi-bin
/test
/cgi-bin/test
/test/cgi-bin

* Note: See the file bin/one_liner to test out this brief example

## Requirements

* [ruby](http://www.ruby-lang.org/) >= 2.2.2

## Install

    $ gem install combos_permutedirs

## Shoutouts

* Hal Brodigan (for teaching me how to write a RubyGem)
* Christopher Abad (for answering all my questions about discrete math)

## Copyright

Copyright (c) 2015 Derek Callaway

See {file:LICENSE.txt} for license information.
