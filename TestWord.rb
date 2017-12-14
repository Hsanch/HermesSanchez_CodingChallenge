class TestWord
	
	def initialize(word)
		#initialize class variables
		@word = word
		@network = []
		@dictionary = []
		@dictionary = TestWord.dictionaryData
		@size = []
	
	end

	attr_accessor :word, :size, :dictionary, :network

	def self.dictionaryData
		dict = []
		path = 'dictionary.txt'
		File.open(path) do |file|
			file.each_line do |element|
				dict << element.chomp
			end
		end
		return dict
	end 

	#user can call set_network to create the social network for his TestWord Object
	def set_network
		@network = calculate_network(@word)
		#updates the size class variable for the TestWord Object
		@size = @network.size
	end

	def calculate_lecenshtein_distance(first, second)
		cost = 0
		#Initialize Hash
		wordHash = Hash.new(0)	
		for i in 0..second.length
			wordHash[[i,0]] = i
		end

		for e in 0..first.length
			wordHash[[0,e]] = e
		end

		#Create Array were the total distance will be found in wordHash[[@word.length-1, second.length-1]]
		for i in 1..second.length
			for e in 1..first.length
				if(first[i-1] == second[e-1])
					cost = 0
				else
					cost = 1
				end
				#Choose the most efficient step (delete, insert, sub)
				wordHash[[i,e]] = [
									(wordHash[[i-1, e]]+1),
									(wordHash[[i, e-1]]+1), 
									(wordHash[[i-1, e-1]] + cost)].min 
			end
		end
		return wordHash[[second.length, first.length]]
	end

	def calculate_network(word)
		network = [] #creates empty network array so that everytime it goes down a level it has a new network
		i = 0
		size = @dictionary.size
		while i <= size-1
			#Ignores the words that are more than 1 character shorter or longer than the search word
			#These words will always have a distance greater than 1
			if !((@dictionary[i].length - @word.length).abs >= 2)				
			#Finds all words with distance of 1 that are also within 1 character of the search word
				if (self.calculate_lecenshtein_distance(word, @dictionary[i]) == 1)
					network << @dictionary[i]
					@dictionary.delete(@dictionary[i])
					#puts "Got a match+++++++++++++++"
					#puts "network: #{network}"
					size +=-1
					i+=-1
					#Previous two steps are accounting for the change in size of @dictionary
				end
			end
			i+=1
		end

		j = 0
		while j <= network.size
			#when the search word returns with an empty network it goes back up a level
			if network.empty? 
				return network
			else
				#Goes down every 'branch' of the social network
				#Once it reaches the bottom, it adds up all the members and returns it
				self.calculate_network(network[j]).each do |element|
					network << element
				end
				return network
			end
			j+=1
		end
		return network
	end
end

