require_relative 'TestWord'

wordOne = TestWord.new("LISTY")
wordOne.set_network
puts wordOne.network.inspect
puts "network size: #{wordOne.size}"
