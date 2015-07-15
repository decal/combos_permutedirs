# **Combinatorial Permutation of Directories**

* `Combinatorics::PermuteDirs`
* [Source](https://github.com/decal/combos_permutedirs)
* [Issues](https://github.com/decal/combos_permutedirs/issues)
* [Documentation](http://rubydoc.info/gems/combos_permutedirs)
* [Email](mailto:decal [AT] ethernet {D0T} org)

## **Description**

* Ever been determined to discover new sub-directories that may exist during a
web application penetration test? This toolset may help in such a situation.  
It creates entirely new fully qualified URL's or local filesystem pathnames 
entirely based on the pre-existing names used by directories which have already
been discovered. Simply provide the output from programs like dirb, DirBuster, 
dirbx, and others as input to the provided Ruby script executables. 

## **Features Slated for Beta Version 0.9.0**
1. By default, utilize names from within the current URL only (quickest approach)
2. Alternatively, use strings from multiple `URI#path` names read at once
3. Optionally, append file names to each `URI` from an included custom data `File`
4. Optionally, combine directory names from an included custom data file or `STDIN`
5. Filter displayed `URI` objects according to Regexp pattern matching

* In essence, this is a collection of modules, methods and scripts for computing 
all [Permutations](http://en.wikipedia.org/wiki/Permutations) within the
[Power Set](https://en.wikipedia.org/wiki/Power_set) of a given `File#dirname` 
path's directory names. Thereafter, their existence may be tested for whether 
they be web-based or a local `File` system `Pathname`. You may use these scripts 
themselves to check for their existence or have them create output files to be 
used as input for another brute-force search or enumeration type scanning tool. 
In plainer terms, all orders of directory names as well as variations of full 
path length are computed. The purpose of this is to discover new paths from 
known ones during reconaissance for web application penetration testing or the 
host-based security hardening of a workstation/server image.

## **Features**

* Tests remote HTTP and HTTPS targets 
  * `URI::HTTP`
  * `URI::HTTPS`
  * `Net::HTTP`
  * `String`

* Because both the combinatorics gem and this gem's methods `yield`, output will
  typically start displaying straight away, unless the k-permutation and power-
  set cardinalities are unusually large (i.e. when dealing with a `Pathname` at 
  extremely deep depths--especially around 20 levels according to benchmarks.)

* Facilitates extension to additional `URI` schemes in the future
  * `Combinatorics::PermuteDirs::Mixin`
* Will check local `File` system to validate current user's permission to certain paths
  * `Combinatorics::PermuteDirs::Local`
* Currently operates on:
  * `URI#path`
* Will operate on:
  * `File#dirname`
  * `Pathname`

## **Examples**

##
## What the `combos_permutedirs` gem looks like in action!!
##

* _Refer to terminal capture typescript `File` objects in the repository root:_
  1. `genhttpdirs1.scr`
  2. `genhttpdirs2.scr`


1. Enumerate over every possible sub-path that could exist within the given 
location using the provided directory names. Of course, this is quite a
small example. The number of elements calculated by the k-permutations and 
power-set algorithms (i.e. their cardinalities) will grow exponentially as does
the number of individual folders in the fully qualified path. In other words,
expect realistic examples to cause much more output than this.

`
> URI('https://host.dom/cgi-bin/test/').permute_path { |x| x.each { |y| p "/#{y.to_a.join('/')}" } }
/
/cgi-bin
/test
/cgi-bin/test
/test/cgi-bin
`

2. Only extract subsets of a given length which also match a given array (_Note: extremely
useful for a script that tests based on RFC2616 HTTP/1.1 response header status codes._)

`
> 'http://google.com/a/b/c/d/e/f'.choose_path(3,["a","c"]) { |x| x.each { |y| y } }
=> [["a", "c", "b"], ["a", "c", "d"], ["a", "c", "e"], ["a", "c", "f"]]
`

* Note: See the scripts in the directory **bin/one_liner** to test out some simple examples

## Requirements

* [Ruby](http://www.ruby-lang.org/) >= 2.2.2

## Install

    $ gem install combos_permutedirs

## Shoutouts

* Hal Brodigan (for helping me practice writing rubygems)
* Christopher Abad (being a resource on combinatorics and other discrete math subjects)

## Copyright

Copyright (c) 2015 _Derek Callaway_

See `LICENSE.txt` for license information.
