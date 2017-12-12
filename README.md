# HermesSanchez_CodingChallenge
Ruby Social Network size calculator, that uses Levenshtein Distance to create each network

Problem
-------
Your task is to count the size of the social network of the word LISTY in the dictionary provided.

We define two words as being friends if the edit distance between them is 1. For this problem, we will
be using Levenshtein distance (http://en.wikipedia.org/wiki/Levenshtein_distance) as our edit distance.

The size of a word's social network is equal to 1 (for the word itself), plus the number of words who
are friends with it, plus the number of friends each of its friends has, and so on. A word is in its own
social network, so if our dictionary is simply `[HI]` then the size of the social network for HI is 1.

## Main Functions: (found in`main.rb`)
There are two main functions: `levenshtein_distance_calculator(first, second)` and `getNetwork(word, dictionary)`. 
#### 1. `levenshtein_distance_calculator(first, second)`
 Used to build two dimensional hash were the Levenshtein Distance of two words with x and y lengths respectively can be found by looking in `hash[[y,x]]`. This hash map is built using the mathematical definiton of Lenshtein Distance (http://en.wikipedia.org/wiki/Levenshtein_distance). 
#### 2. `getNetwork(word, dictionary)`
This function initially finds the social network for the search word, in this case `"Listy"`, and then goes down each 'branch' recursively, building social networks for each member (kind of like in a Node Tree) until it finds an empty network. After finding the empty network it simply concatenates all of the networks into one. 

##### This program will take approximately 30 seconds to search through the entire `\dictionary.txt\`in search for `"LISTY"'s` social network. The end result will be a social network of size 90. 

##### Also, there are plenty of comments throughout the code which should explain any other important point
