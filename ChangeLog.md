### 0.8.0 / 2015-07-02

* First working pre-release of code to GitHub in RubyGem directory structure

### 0.8.5 / 2015-07-12

* Created choose_path mixin method to supplement permute_path mixin method
* Renamed mixin methods to a better naming scheme, but retained old one (see next)
* Appended mixin method aliases for old identifiers, similar method naming, etc.
* Moved enum_for return statements to end of mixin methods via ternary operator and block_given?
* New script in the "bin" directory "profile_one_liner" shows Ruby method profiling
* Added more specifications for testing with "rake spec"
* Moved unrelated helpers, i.e. String#blank in "lib" outside of "lib/combos_permutedirs" folder
* Made skeleton for "httpdirscan" script in the "bin" folder which will check HTTP status codes
* Removed whitespace from require statements
