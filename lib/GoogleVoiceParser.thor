# #!/usr/bin/env ruby
require 'thor'
require 'pry'
require 'gruff'
require_relative 'SingleFileParser.rb'
require_relative 'MakeGraph.rb'
class GoogleVoiceParser < Thor
  option :dir, default: "./texts"
  desc "Make a Graph", "do it"
  def hello(name, from=nil)
    puts "from: #{from}" if from
    puts "Hello #{name}"
  end
  desc "Make a Graph", "do it"
  def graph
    puts "got here"
    a = VoiceParser(options[:dir])
    g = MakeGraph(a.generateBigArray())
    binding.pry
    g.generateGraph("love")
  end
end
