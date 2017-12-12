#find size of social network for testWord
testWord = "LISTY"
socialNetwork = [testWord]

#move contents of dictionary file to a string array called dictionary

#All five dictionaries and an extra one created
path = 'very_small_test_dictionary.txt'
path2 = 'eighth_dictionary.txt'
path3 = 'quarter_dictionary.txt'
path4 = 'half_dictionary.txt'
path5 = 'dictionary.txt'
testPath = 'testDictionary.txt'
#Read in specific dictionary 
dictionary = []
File.open(path5) do |file|
	file.each_line do |element|
		dictionary << element.chomp
	end 
end

#Uses mathematical definition of Levenshtein Distance
def LevenshteinDistance (first, second)
	cost = 0
	#Initialize Hash from 1 to the length of each word, and 0 at (0,0)
	wordHash = Hash.new(0)	
	for i in 0..second.length
		wordHash[[i,0]] = i
	end

	for e in 0..first.length
		wordHash[[0,e]] = e
	end
#Build the rest of the Hashmap, were the Levenshetein Distance will be found in wordHash[[second.length, first.length]]
	for i in 1..second.length
		for e in 1..first.length
			if(first[i-1] == second[e-1])
				cost = 0
			else
				cost = 1
			end
			#Choose the most efficient step (delete, insert, sub), According to the mathematical definition of Levenshtein Distance
			wordHash[[i,e]] = [
								(wordHash[[i-1, e]]+1),
								(wordHash[[i, e-1]]+1), 
								(wordHash[[i-1, e-1]] + cost)].min 
		end
	end
	#returns the distance
	return wordHash[[second.length, first.length]]
end

def getNetwork(word, dictionary)
	#Eliminate the search word from the dictionary because it will always be in its own network
	dictionary.delete(word)
	network = [] #creates empty network array so that everytime it goes down a level it has a new network
	i = 0
	size = dictionary.size
	while i <= size-1
		#Ignores the words that are more than 1 character shorter or longer than the search word
		#These words will always have a distance greater than 1
		if (dictionary[i].length - word.length).abs >= 2
			i+=1
		else #Finds all words with distance of 1 that are also within 1 character of the search word
			if (LevenshteinDistance(word,dictionary[i]) == 1)
				network << dictionary[i]
				dictionary.delete(dictionary[i])
				size +=-1
				i+=-1
				#Previous two steps are accounting for the elimination
			end
		end
		i+=1
	end


	# "network: #{network}"

	#Recursive part of the function
	j = 0
	while j <= network.size
		#puts "network[0]: #{network[0]}"
		if network.empty? 
			return network
		else
			#Goes down every 'branch' of the social network
			#Once it reaches the bottom, it adds up all the members amd returns it
			getNetwork(network[j], dictionary).each do |element|
				network << element
			end
			return network
		end
		j+=1
	end
	return network
end

#Printing out the final solution
socialNetwork = getNetwork(testWord, dictionary) 
socialNetwork << testWord #Adds the initial word to the network
puts socialNetwork.inspect	
size = socialNetwork.size 
puts size #Total size of network
