# Combinatorics

* [Source](https://github.com/decal/combos_permutedirs)
* [Issues](https://github.com/decal/combos_permutedirs/issues)
* [Documentation](http://rubydoc.info/gems/combos_permutedirs)
* [Email](mailto:decal [AT] ethernet {D0T} org)

## Description

A collection of modules and methods for computing power sets of 
[Permutations](http://en.wikipedia.org/wiki/Permutations) on web-based and file
system paths and then testing for their existence.

## Features

* Tests remote HTTP(S) targets 
  * {Combinatorics::PermuteDirs::HTTP}
* Checks local filesystem if current user has permissions for subdirectories 
  * {Combinatorics::PermuteDirs::OSFS}

## Examples

Enumerate over every sub-range between two ranges:

    Combinatorics::PermuteDirs::OSFS.new('a/b/')
    # => ['a/b', 'b/a']

## Requirements

* [ruby](http://www.ruby-lang.org/) >= 2.2.2

## Install

    $ gem install combos_permutedirs

## Copyright

Copyright (c) 2015 Derek Callaway

See {file:LICENSE.txt} for license information.
