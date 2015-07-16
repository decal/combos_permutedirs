# encoding: utf-8
# 
# @author Derek Callaway <decal@ethernet.org>
# 
# @version 0.8.8
#
# @since 0.8.8
#

module Combinatorics::PermuteDirs::Parser
  # 
  # @param [String] afile
  #   Location of file to parse names as String objects without any slash delimiters
  #
  # @return [Array<String>] 
  #   Return an array object containing undelimited strings read from `afile`
  #
  # @note Method does not expect `Pathname` or `URI` style input; it has been 
  #   optimized for handling names as "normalized" strings only!
  #
  # @see parse_path_file
  #
  # @see parse_uri_file
  #
  def parse_str_file(afile)
    aretn = []

    File.new(afile, 'rb').readlines.each do |l|
      begin
        aretn << l
      rescue Exception => e
        STDERR.puts(e.inspect)
        STDERR.puts(e.backtrace.join(' '))

        next
      end
    end

    aretn.sort!
    aretn.uniq!

    aretn ? aretn : %w{}
  end
end
