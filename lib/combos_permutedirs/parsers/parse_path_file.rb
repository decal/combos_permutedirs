# encoding: utf-8
# 
# @author Derek Callaway <decal@ethernet.org>
# 
# @version 0.8.8
#
# @since 0.8.8
#

require'pathname'

module Combinatorics::PermuteDirs::Parser
  #
  # Parse unique names from paths delimited by a forward slash in given file
  #
  # @param [String] afile
  #   location of file to read slash-delimited `Pathname` style strings from
  #
  # @raise [EOFError]
  #   Provided input must not be empty
  #
  # @return [Array]
  #   Returns sorted array of unique names extracted from path strings in `afile`
  #
  # @note `RuntimeError` detection initializes each input `String` as a `Pathname`
  # 
  # @see Combinatorics::PermuteDirs::Helpers::parse_str_file
  # 
  # @see Combinatorics::PermuteDirs::Helpers::parse_uri_file
  #
  # Essentially, each input string should be represented as a string containing
  #   relative and/or fully qualified filesystem pathnames
  #
  def parse_path_file(afile)
    aretn = []

    begin
      f = File.new(afile, 'rb')
      s = f.size

      raise(EOFError,'Provided input must not be empty!') if s.zero?

      f.readlines.each do |l|
        p = nil

        begin
          p = Pathname.new(l)

          l.split('/').each do |z| 
            aretn << z
          end
        rescue Exception => e
          if p.blank?
            STDERR.print('*%* #{__FILE__:__LINE__} Combinatorics::RuntimeDirs::Helpers::parse_path_file ')
            STDERR.puts('Given Erroneous Pathname Data!') 
          end

          STDERR.puts("#{e.inspect}\n#{e.backtrace.join(' ')}\n\n")

          next
        end
      end
    rescue Exception => e
      STDERR.puts(e.inspect)
      STDERR.puts(e.backtrace.join(' '))

      return nil
    end

    aretn.sort!
    aretn.uniq!

    aretn ? aretn : %w{}
  end
end
