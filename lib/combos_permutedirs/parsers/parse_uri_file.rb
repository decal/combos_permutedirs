# encoding: utf-8
# 
# @author Derek Callaway <decal@ethernet.org>
# 
# @version 0.8.8
#
# @since 0.8.8
#

require'uri'

include Combinatorics::PermuteDirs

module Combinatorics::PermuteDirs::Parser
  #
  # Read URI's from given file and return array of names from within their paths
  #
  # @param [String] afile
  #   Location of file to parse `URI` style data from
  #
  # @param [Fixnum] isesc
  #   An integer value denotating how to handle CGI escaping, also known as
  #   "URL-encoding" or "percent-encoding" 
  #
  # @param [Float] isesc
  #
  #
  # @return [Array<String>]
  #   Return unique name sort of `URI#path` attributes as an `Array` `Object`
  #   with a `String` 
  #
  # @see parse_path_file
  #
  # @see parse_str_file
  def parse_uri_file(afile, isesc = 0, acase = :none)
    aretn = %w{}

    File.new(afile, 'rb').readlines.each do |l|
      begin
        p = URI(l)

        p.path.split('/').each { |s| aretn << s }
      rescue Exception => e
        STDERR.puts(e.inspect)
        STDERR.puts(e.backtrace.join(' '))

        next
      end
    end

    begin
      aretn.sort!
      aretn.uniq!
    rescue Exception => e
      warn("*!* #{$!} #{$@}") if Config.debug
    end

    aretn
  end
end
