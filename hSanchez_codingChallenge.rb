#find size of social network for testWord
testWord = "LISTY"
socialNetwork = [testWord]

#move contents of dictionary file to a string array called dictionary

path = 'very_small_test_dictionary.txt'
path2 = 'eighth_dictionary.txt'
path3 = 'quarter_dictionary.txt'
path4 = 'half_dictionary.txt'
path5 = 'dictionary.txt'
testPath = 'testDictionary.txt'
dictionary = []
File.open(path5) do |file|
	file.each_line do |element|
		dictionary << element.chomp
	end 
end

#Uses mathematical definition of Levenshtein Distance
def LevenshteinDistance (first, second)
	cost = 0
	#Initialize Hash 
	wordHash = Hash.new(0)	
	for i in 0..second.length
		wordHash[[i,0]] = i
	end

	for e in 0..first.length
		wordHash[[0,e]] = e
	end

#Create Array were the total distance will be found in wordHash[[first.length-1, second.length-1]]
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
	#puts wordHash
	return wordHash[[second.length, first.length]]
end

def getNetwork(word, dictionary)
	dictionary.delete(word)
	network = []
	i = 0
	size = dictionary.size
	while i <= size-1

		#Ignores the words that are more than 1 character shorter or longer than word
		if (dictionary[i].length - word.length).abs >= 2
			i+=1
		else #Finds all words with distance of 1
			if (LevenshteinDistance(word,dictionary[i]) == 1)
				network << dictionary[i]
				dictionary.delete(dictionary[i])
				size +=-1
				i+=-1
			end
		end
		i+=1
	end


	# "network: #{network}"
	j = 0
	while j <= network.size
		#puts "network[0]: #{network[0]}"
		if network.empty? 
			#puts "made it to if"
		else
			#puts "Made it"
			getNetwork(network[j], dictionary).each do |element|
				network << element
			end
			return network
		#	network.each do |element|
		#		network << getNetwork(element, dictionary)
		#	end
		end
		j+=1
	end
	return network
end

#puts LevenshteinDistance("hermes", "hermano")

socialNetwork = getNetwork(testWord, dictionary) 
socialNetwork << testWord
puts socialNetwork.inspect	
size = socialNetwork.size 
puts size