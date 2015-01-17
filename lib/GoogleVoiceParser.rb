# #!/usr/bin/env ruby
require 'thor'
require 'date'
require 'pry'
require 'gruff'
require 'nokogiri'
require_relative './SingleFileParser.rb'
require_relative './MakeGraph.rb'
class GoogleVoiceParser < Thor
  option :dir, default: "./texts"
  option :word, default: "love"
  option :amount, default: 10
  desc "Make a Graph", "do it"
  def graph
    puts "got here"
    a = VoiceParser.new(options[:dir])
    g = MakeGraph.new(a.generateBigArray())
    g.generateGraph(options[:word], options[:amount].to_i)
  end
end
GoogleVoiceParser.start(ARGV)
