require_relative 'TestWord'

wordOne = TestWord.new("LISTY")
wordOne.set_network
wordOne.set_network_size
puts wordOne.network.inspect
puts "network size: #{wordOne.size}"
