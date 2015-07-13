# encoding: utf-8
#
# @author Derek Callaway <decal@ethernet.org>
#
# @version 0.8.5
#
# @since 0.8.0
#
# @note PermuteDirs module namespace is distinctly separate from combinatorics gem
#
require'combinatorics'

module Combinatorics::PermuteDirs
  #
  # @private VERSION
  #   Actual long-form version number string at current point in development
  #
  VERSION = '0.8.5'
  #
  # @private CURRENT_VERSION
  #   This is simply a more descriptive constant identifier for `VERSION`
  #
  CURRENT_VERSION = VERSION
  #
  # @private FIRST_VERSION
  #   Initial commit to GitHub
  #
  FIRST_VERSION = '0.8.0'
  #
  # @private ALPHA_VERSION
  #   Features are still being added under these sub-minor version numbers
  #
  ALPHA_VERSION = '0.8.8'
  #
  # @private BETA_VERSION
  #   Features are no longer being added, but keep an eye open for buggy code
  #
  BETA_VERSION = '0.9.5'
  #
  # @private RELEASE_VERSION
  #   The official release of the framework/toolkit will occur at this version
  # 
  # @note all specifications under `rake spec` must run perfect for this
  #
  RELEASE_VERSION = '1.0.0'
  # 
  # @private UPDATE_VERSION
  #   The second official release including implementation of user requests
  #
  # @note all specifications under `rake spec` must run perfect for this as well
  #
  UPDATE_VERSION = '2.0.0'
end
