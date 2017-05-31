# encoding: utf-8
#
# @author Derek Callaway <deca@@ethernet.org>
#
# @version 0.8.8
#
# @since 0.8.8
#
# This file initializes configuration settings in the primary gem-wide 
#   namespace scope, `Combinatorics::PermuteDirs`, as well as more granular
#   nested settings such as the subspace identified as `PermuteDirs::Mixin`.
#

require'singleton'
#require'combinatorics'

module Combinatorics
  module PermuteDirs
    module Mixin
      protected def debug
        @debug
      end

      private def debug=(v)
        @debug = v
      end

      protected def verbose
        @verbose
      end

      private def verbose=(v)
        @verbose = v
      end

      protected def profile
        @profile
      end

      private def profile=(v)
        @profile = v
      end

      module_function :debug, :debug=, :verbose, :verbose=, :profile, :profile=
    end

    module Helper
      protected def debug
        @debug
      end

      private def debug=(v)
        @debug = v
      end

      protected def verbose
        @verbose
      end

      private def verbose=(v)
        @verbose = v
      end

      protected def profile
        @profile
      end

      private def profile=(v)
        @profile = v
      end

      module_function :debug, :debug=, :verbose, :verbose=, :profile, :profile=
    end

    module Parser
      attr_reader :debug, :verbose, :profile

      @debug, @verbose, @profile = false, 0, false

      private def debug=(v)
        @debug = v
      end

      private def verbose=(v)
        @verbose = v
      end

      private def profile=(v)
        @profile = v
      end
    end

    module Setup 
      attr_reader :debug, :verbose, :profile

      @debug, @verbose, @profile = false, 0, false

      class Config
        #
        # Only one Config class object can be instantiated at any given time;
        #   this is because it's defined as a Singleton. Moreover, it's defined
        #   as protected to avoid modifications of settings by external code. 
        #   "External" means code outside of the current Ruby gem package.
        #
        # @param [Hash] opts
        #   Lookup table for passing the configuration's initialized values 
        #
        # @option opts [NilClass, FalseClass, TrueClass] :debug Debugging
        #   messages are enabled when this is set to true.
        #
        # @option opts [NilClass, Fixnum, Integer, Float] :verbose When set to 
        #   positive whole numbers above zero, denotes the verbosity level for
        #   displaying additional code statistics and other info to the user; no
        #   verbosity exists when this is set to zero. 
        #
        # @todo Whenever a floating point variable is taken advantage of, the 
        #       verbosity of information displayed by code within deeper namespaces 
        #       will be affected by what the tenths place (e.g. after the decimal) 
        #       holds. If there are zero tenths, then there's zero verbosity, while 
        #       one tenth means minimal verbosity, and so on..
        #   
        # @option opts [NilClass, FalseClass, TrueClass] :profile This will
        #   enable profiling in the current PID's (process identifier's) runtime
        #   by invoking a require statement that loads the Ruby standard library
        #   profiler.
        #
        # @raise [TypeError]
        #   `adbug` or `opts[:debug]` must equal a true or false value only
        #
        # @raise [TypeError]
        #   `averb` or `opts[:verbose]` must be a kind of Fixnum, Integer or
        #   Float class object
        #
        # @raise [TypeError]
        #   `aprof` or `opts[:profile]` must equal a true or false value only
        #
        # @raise [RangeError]
        #   `averb` cannot be less than zero
        #
        # @since 0.8.8
        #
        # @todo add rspec directives for this class to spec/config_spec.rb
        #
        # @private [FalseClass, TrueClass]@@debug
        #   Constant that denotes whether debugging is to be enabled in the Mixin
        #   subspace under the parent module PermuteDirs defined by this gem. If
        #   it's set to nil or false, then all debugging is disabled for mixin
        #   methods. Otherwise, if it's set to true, then debugging messages will
        #   be displayed on the standard error I/O stream.
        #
        # @private [Fixnum, Integer, Float]@@verbose
        #   A class variable which is assigned the current unsigned verbosity 
        #   level number value--which may have been updated between now and 
        #   previous access to the same variable; in other words, a new number
        #   may be assigned during a single process identifier's (PID's) runtime
        #
        # @private [FalseClass, TrueClass]@@profile
        #   Another boolean value similar to @@debug`. When this class variable 
        #   is set to true, then Ruby utilizes its standard library profiler to
        #   to count invocations of and clock cycles used by all activated methods
        #
        def self.create(opts = {})
          adbug = opts.key?(:debug) ? opts[:debug] : @debug
          averb = opts.key?(:verbose) ? opts[:verbose] : @verbose
          aprof = opts.key?(:profile) ? opts[:profile] : @profile

          raise(TypeError,'adbug must equal a true or false value only!') if !(adbug.eql?(true) or adbug.eql?(false))
          raise(TypeError,'aprof must equal a true or false value only!') if !(aprof.eql?(true) or aprof.eql?(false))
          raise(TypeError,'averb must be a kind of Fixnum, Integer or Float Object!') if !(averb.kind_of?(Fixnum) or averb.kind_of?(Integer) or averb.kind_of?(Float))
          raise(RangeError,'averb cannot be less than zero!') if averb < 0

          athrs = []

          athrs << Thread.new do
            begin
              Mixin.class_variable_set(:@debug, adbug)
              Mixin.class_variable_set(:@verbose, averb)
              Mixin.class_variable_set(:@profile, aprof)
            rescue Exception => e
              warn("#{e} #{e.backtrace_locations.join(' ')}")
            end
          end

          athrs << Thread.new do
            begin
              Helper.class_variable_set(:@debug, adbug)
              Helper.class_variable_set(:@verbose, averb)
              Helper.class_variable_set(:@profile, averb)
            rescue Exception => e
              warn("#{e} #{e.backtrace_locations.join(' ')}")
            end
          end

          athrs.each do |t| 
            t.join 
          end

          @debug, @verbose, @profile = adbug, averb, aprof
        end

        def self.debug=(xdbug)
          raise(TypeError,'xdbug must equal a false or true value!') if !(xdbug.eql?(false) or xdbug.eql?(true))

          @debug = xdbug
        end

        def self.verbose=(xverb)
          raise(TypeError,'xverb must be a kind of Fixnum, Integer or Float class Object!') if !(xverb.kind_of?(Fixnum) or xverb.kind_of?(Integer) or xverb.kind_of?(Float))

          @verbose = xverb
        end

        def self.profile=(xprof)
          raise(TypeError,'xprof must be a false or true value!') if !(xprof.eql?(false) or xprof.eql?(true))

          @profile = xprof
        end

        include Singleton
      end
    end
  end
end

include Combinatorics::PermuteDirs, Combinatorics::PermuteDirs::Setup

# Config.create( { :debug => true, :verbose => 1, :profile => false } )
