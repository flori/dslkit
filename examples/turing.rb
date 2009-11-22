require 'term/ansicolor'
require 'dslkit/polite'

module Turing
  class Tape
    def initialize(*initials)
      @left = []
      @head = 'B'
      @right = []
      c = 0
      first = true
      for initial in initials
        if first
          c += 1
          first = false
        else
          @left.push 'B'
          c += 1
        end
        for s in initial.split(//)
          @left.push s
          c += 1
        end
      end
      c.times { left }
    end

    def read
      @head
    end

    def write(symbol)
      @head = symbol
      self
    end

    def left
      @right.push @head
      @head = @left.pop || 'B'
      self
    end

    def right
      @left.push @head
      @head = @right.pop || 'B'
      self
    end

    def clear
      @left.clear
      @right.clear
      @head = 'B'
      self
    end

    def to_s
      "#@left#{Term::ANSIColor.red(@head)}#{@right.reverse}"
    end
    
    alias inspect to_s
  end

  module States
    class State
      attr_accessor :tape
    end

    class Cond < State
      def initialize(opts = {})
        @if, @then, @else = opts.values_at :if, :then, :else
      end

      def execute
        tape.read == @if ? @then : @else
      end

      def to_s
        "if #@if then #@then else #@else"
      end
    end

    class Left < State
      def initialize(opts = {})
        @goto = opts[:goto]
      end

      def execute
        tape.left
        @goto
      end

      def to_s
        "left, goto #@goto"
      end
    end

    class Right < State
      def initialize(opts = {})
        @goto = opts[:goto]
      end

      def execute
        tape.right
        @goto
      end

      def to_s
        "right, goto #@goto"
      end
    end

    class Write < State
      def initialize(opts = {})
        @symbol, @goto = opts.values_at :symbol, :goto
      end

      def execute
        tape.write @symbol
        @goto
      end

      def to_s
        "write #@symbol, goto #@goto"
      end
    end

    class Halt < State
      def initialize(opts = {})
      end

      def execute
        -1
      end

      def to_s
        'halt'
      end
    end
  end

  class BaseMachine
    def initialize(program = nil)
      @states = []
      if program
        block_given? and raise "use either program source string or a block"
        interpret program
      else
        instance_eval(&Proc.new)
      end
    end

    def step(*tapes)
      @stepping = true
      run(*tapes)
    end
  end

  class SingleTapeMachine < BaseMachine
    include DSLKit::Deflect
    include DSLKit::Interpreter

    def initialize(program = nil)
      deflector = Deflector.new do |number, id, name, *args|
        opts = Hash === args.last ? args.pop : {}
        state = States.const_get(name.to_s.capitalize).new(opts)
        @states[number] = state
      end
      deflect_start(Integer, :method_missing, deflector)
      super
    ensure
      deflect_stop(Integer, :method_missing) if deflect?(Integer, :method_missing)
    end

    def run(*tape)
      @tape = Tape.new(*tape)
      @states.each { |s| s and s.tape = @tape }
      goto_state = -1
      @states.any? { |s| goto_state += 1; s }
      begin
        printf "%3u: %s", goto_state, @tape
        @stepping ? STDIN.gets : puts
        goto_state = @states[goto_state].execute
      end until goto_state < 0
    end

    def to_s
      result = ''
      @states.each_with_index do |state, i|
        result << "%3u. %s\n" % [ i, state ]
      end
      result
    end
  end

  class MultiTapeMachine < BaseMachine
    include DSLKit::Deflect
    include DSLKit::Interpreter

    def initialize(program = nil)
      deflector = Deflector.new do |number, id, name, *args|
        opts = Hash === args.last ? args.pop : {}
        tape = *args
        state = States.const_get(name.to_s.capitalize).new(opts)
        @states[number] = [ tape, state ]
      end
      deflect_start(Integer, :method_missing, deflector)
      super
    ensure
      deflect_stop(Integer, :method_missing) if deflect?(Integer, :method_missing)
    end

    def run(*tapes)
      tapes.unshift ''
      @tapes = tapes.map { |tape| Tape.new(tape) }
      goto_state = -1
      @states.any? { |s| goto_state += 1; s }
      begin
        printf "%3u: %s", goto_state, @tapes * ' '
        @stepping ? STDIN.gets : puts
        tape, state = @states[goto_state]
        state.tape = tape ? @tapes[tape] : nil
        goto_state = state.execute
      end until goto_state < 0
    end

    def to_s
      result = ''
      @states.each_with_index do |(tape, state), i|
        result << "%3u. %1u: %s\n" % [ i, tape, state ]
      end
      result
    end
  end
end

if ARGV.any?
  include Turing
  filename, *tapes = ARGV
  machine_type =
    case ext = File.extname(filename)
    when '.stm'
      SingleTapeMachine
    when '.mtm'
      MultiTapeMachine
    else
      raise "unknown turing machine suffix: #{ext}, use .stm or .mtm"
    end
  tm = machine_type.new(File.read(filename))
  $DEBUG ? tm.step(*tapes) : tm.run(*tapes)
end
