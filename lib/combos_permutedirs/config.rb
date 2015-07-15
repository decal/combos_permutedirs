# encoding: utf-8
#
#@@author Derek Callaway <deca@@ethernet.org>
#
#@@version 0.8.8
#
#@@since 0.8.8
#
# This file initializes configuration settings in the primary gem-wide 
#   namespace scope, `Combinatorics::PermuteDirs`, as well as more granular
#   nested settings such as the subspace identified as `PermuteDirs::Mixin`.
#

require'singleton'
require'combinatorics'

module Combinatorics
  module PermuteDirs
    module Mixin
      class Config
        attr_reader :debug, :verbose, :profile
      end
    end

    module Helper
    end

    module Setup 
      module_function

      def debug
        @debug
      end

      def debug=(v)
        @debug = v
      end

      def profile
        @profile
      end

      def profile=(v)
        @profile = v
      end

      def verbose
        @verbose
      end

      def verbose=(v)
        @verbose = v
      end

      class Current
        #
        # Only one Current class object can be instantiated at any given time;
        #   this is because it's defined as a Singleton. Moreover, it's defined
        #   as protected to avoid modifications of settings by external code. 
        #   "External" means code outside of the current Ruby gem package.
        #
        #@@param [Hash] opts
        #   Lookup table for passing the configuration's initialized values 
        #
        #@@option sopts [NilClass, FalseClass, TrueClass] :debug Debugging
        #   messages are enabled when this is set to true.
        #
        #@@option sopts [NilClass, Fixnum, Integer, Float] :verbose When set to 
        #   positive whole numbers above zero, denotes the verbosity level for
        #   displaying additional code statistics and other info to the user; no
        #   verbosity exists when this is set to zero. 
        #
        #@@todo Whenever a floating point variable is taken advantage of, the 
        #       verbosity of information displayed by code within deeper namespaces 
        #       will be affected by what the tenths place (e.g. after the decimal) 
        #       holds. If there are zero tenths, then there's zero verbosity, while 
        #       one tenth means minimal verbosity, and so on..
        #   
        #@@option sopts [NilClass, FalseClass, TrueClass] :profile This will
        #   enable profiling in the current PID's (process identifier's) runtime
        #   by invoking a require statement that loads the Ruby standard library
        #   profiler.
        #
        #@@raise [TypeError]
        #   `adbug` or `opts[:debug]` must equal a true or false value only
        #
        #@@raise [TypeError]
        #   `averb` or `opts[:verbose]` must be a kind of Fixnum, Integer or
        #   Float class object
        #
        #@@raise [TypeError]
        #   `aprof` or `opts[:profile]` must equal a true or false value only
        #
        #@@raise [RangeError]
        #   `averb` cannot be less than zero
        #
        #@@since 0.8.8
        #
        #@@todo add rspec directives for this class to spec/config_spec.rb
        #
        #@@private [FalseClass, TrueClass]@@debug
        #   Constant that denotes whether debugging is to be enabled in the Mixin
        #   subspace under the parent module PermuteDirs defined by this gem. If
        #   it's set to nil or false, then all debugging is disabled for mixin
        #   methods. Otherwise, if it's set to true, then debugging messages will
        #   be displayed on the standard error I/O stream.
        #
        #@@private [Fixnum, Integer, Float]@@verbose
        #   A class variable which is assigned the current unsigned verbosity 
        #   level number value--which may have been updated between now and 
        #   previous access to the same variable; in other words, a new number
        #   may be assigned during a single process identifier's (PID's) runtime
        #
        #@@private [FalseClass, TrueClass]@@profile
        #   Another boolean value similar to @@debug`. When this class variable 
        #   is set to true, then Ruby utilizes its standard library profiler to
        #   to count invocations of and clock cycles used by all activated methods
        #
        def self.create(opts = {})
          adbug = opts.key?(:debug) ? opts[:debug] : false
          averb = opts.key?(:verbose) ? opts[:verbose] : 0
          aprof = opts.key?(:profile) ? opts[:profile] : false

          raise(TypeError,'adbug must equal a true or false value only!') if !(adbug.eql?(true) or adbug.eql?(false))
          raise(TypeError,'aprof must equal a true or false value only!') if !(aprof.eql?(true) or aprof.eql?(false))
          raise(TypeError,'averb must be a kind of Fixnum, Integer or Float Object!') if !(averb.kind_of?(Fixnum) or averb.kind_of?(Integer) or averb.kind_of?(Float))
          raise(RangeError,'averb cannot be less than zero!') if averb < 0

          athrs = []

          athrs << Thread.new { 
            begin
              Mixin.class_variable_set(:@@debug, adbug)
              Mixin.class_variable_set(:@@verbose, averb)
              Mixin.class_variable_set(:@@profile, aprof)
            rescue Exception => e
              warn("#{e} #{e.backtrace_locations.join(' ')}")
            end
          }

          athrs << Thread.new {
            begin
              Helper.class_variable_set(:@@debug, adbug)
              Helper.class_variable_set(:@@verbose, averb)
              Helper.class_variable_set(:@@profile, averb)
            rescue Exception => e
              warn("#{e} #{e.backtrace_locations.join(' ')}")
            end
          }

          athrs.each do |t| 
            t.join 
          end

         @@debug, @@profile, @@verbose = adbug, averb, aprof
        end

=begin
        protected def debug=(xdbug)
          raise(TypeError,'xdbug must equal a false or true value!') if !(xdbug.eql?(false) or xdbug.eql?(true))

          @debug = xdbug
        end

        protected def verbose=(xverb)
          xvcls = xverb.class

          raise(TypeError,'xverb must be a kind of Fixnum or Integer class object!') if !(xvcls.kind_of?(Fixnum) or xvcls.kind_of?(Integer))

          @verbose = xverb
        end

        protected def profile=(xprof)
          raise(TypeError,'xprof must be a false or true value!') if !(xprof.eql?(false) or xprof.eql?(true))

          @profile = xprof
        end

        def debug?
         @@debug
        end

        protected def verbose?
         @@verbose >= 1
        end

        protected def profile?
         @@profile
        end

        protected def zero_verbose?
         @@verbose.zero?
        end

        protected def one_verbose?
         @@verbose.eql?(1)
        end

        protected def two_verbose?
         @@verbose.eql?(2)
        end

        protected def verbose_pos?
         @@verbose > -1
        end

        protected def verbose_any?
         @@verbose >= 1
        end
=end

        def self.finalize!
          Setup::debug = @@debug
          Setup.verbose = @@verbose
          Setup.profile = @@profile

          true
        end
=begin

        alias_method :set_debug, :debug=
        alias_method :debug_set, :debug=
        alias_method :set_verbose, :verbose=
        alias_method :verbose_set, :verbose=
        alias_method :set_profile, :profile=
        alias_method :profile_set, :profile=
        alias_method :is_debug, :debug?
        alias_method :is_debug?, :debug?
        alias_method :isset_debug, :debug?
        alias_method :isset_debug?, :debug?
        alias_method :verbose_none?, :zero_verbose?
        alias_method :verbose_zero?, :zero_verbose?
        alias_method :none_verbose?, :zero_verbose?
        alias_method :isset_verbose, :verbose?
        alias_method :isset_verbose?, :verbose?
        alias_method :is_verbose, :verbose?
        alias_method :is_verbose?, :verbose?
        alias_method :is_profile, :profile?
        alias_method :is_profile?, :profile?
        alias_method :isset_profile, :profile?
        alias_method :isset_profile?, :profile?
        alias_method :one_verbose, :one_verbose?
        alias_method :two_verbose, :two_verbose?
        alias_method :verbose_one, :one_verbose?
        alias_method :verbose_one?, :one_verbose?
        alias_method :verbose_two, :two_verbose?
        alias_method :verbose_two?, :two_verbose?
        alias_method :verbose_pos, :verbose_pos?
        alias_method :verbose_positive, :verbose_pos?
        alias_method :verbose_pos?, :verbose_pos?
        alias_method :verbose_positive?, :verbose_pos?
        alias_method :pos_verbose, :verbose_pos?
        alias_method :pos_verbose?, :verbose_pos?
        alias_method :positive_verbose, :verbose_pos?
        alias_method :positive_verbose?, :verbose_pos?
        alias_method :verbose_any, :verbose_any?
        alias_method :any_verbose, :verbose_any?
        alias_method :any_verbose?, :verbose_any?
        alias_method :verbose_some, :verbose_any?
        alias_method :verbose_some?, :verbose_any?
        alias_method :some_verbose, :verbose_any?
        alias_method :some_verbose?, :verbose_any?
=end

        include Singleton
      end
    end
  end
end

include Combinatorics::PermuteDirs, Combinatorics::PermuteDirs::Setup

Current.create( { :debug => true, :verbose => 1, :profile => false } )

Current.finalize!

p Setup.debug
p Setup.verbose
p Setup.profile
