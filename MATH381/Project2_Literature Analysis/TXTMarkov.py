# Markov Chain for regular text files.

import sys, os, json, random
import copy

import random
import numpy as np
import re
import math

import glob, os

# size of matrix (N x N)
N = 25

# Transition Matrix class used to create markov chain. (can ignore)
class TransitionMatrix:
    
    def __init__(self, init_name=None):
        self.matrix = {}
        self.norm_matrix = None
        self.fname = init_name if init_name else 'data'
        self.curr_state = None
        self.choice_matrix = None

    def add_transition(self, prev_state, next_state):
        if prev_state in self.matrix.keys():
            if next_state in self.matrix[prev_state]:
                self.matrix[prev_state][next_state]+=1
            else:
                self.matrix[prev_state][next_state]=1

        else:
            self.matrix[prev_state] = {}
            self.matrix[prev_state][next_state]=1
            
            
    def normalize(self):
        new_matrix = {}
        for prev_freq in self.matrix.keys():
            curr_freq_data = self.matrix[prev_freq]
            total = sum(curr_freq_data.values())
            new_dict = {}
            for key in curr_freq_data.keys():
                new_dict[key] = curr_freq_data[key]/total
            new_matrix[prev_freq] = new_dict

        self.norm_matrix = new_matrix
        
    # Save the data into a file
    # Returns either the file name for the frequencies,
    # or the file name for the normalized probabilities
    def save(self, norm=False):
        self.normalize()
        frequency_data = json.dumps(self.matrix)
        normalized_data = json.dumps(self.norm_matrix)
        open(self.fname + '.json', 'w').write(frequency_data)
        open(self.fname + '_norm.json', 'w').write(normalized_data)
        if not norm:
            return self.fname + '.json'
        return self.fname + '_norm.json'

    # Add data from another existing matrix into the current object.
    # Combines and sums the new data with the data in the structure
    def load_data(self, filepath):
        if os.path.isfile(filepath):
            prob_raw = open(filepath)
            prob_raw_data = prob_raw.read()
            new_matrix = json.loads(prob_raw_data)
            for key in new_matrix.keys():
                if key in self.matrix:
                    for transition in new_matrix[key].keys():
                        if transition in self.matrix[key]:
                            self.matrix[key][transition] += new_matrix[key][transition]
                        else:
                            self.matrix[key][transition] = new_matrix[key][transition]
                else:
                    self.matrix[key] = new_matrix[key]
            self.normalize()

    def initialize_chain(self):
        self.normalize()
        self.curr_state = random.choice(list(self.matrix.keys()))
        self.choice_matrix = copy.deepcopy(self.norm_matrix)
        for key in self.choice_matrix:
            acc = 0
            for outcome in self.choice_matrix[key]:
                acc += self.choice_matrix[key][outcome]
                self.choice_matrix[key][outcome] = acc

    def get_next_outcome(self):
        rand = random.random()
        if not self.curr_state in self.choice_matrix:
            self.curr_state = random.choice(list(self.choice_matrix.keys()))
        for key in self.choice_matrix[self.curr_state]:
            if self.choice_matrix[self.curr_state][key] >= rand:
                self.curr_state = key
                return key



# Load in text file and create a transition matrix
# INPUT:
#   filename    String of file's name.
# OUTPUT:
#   maxLengthWord     length of longest word - used in compareMatrices to create best size matrix.
def loadTextFile(filename, matrix):
    maxLengthWord = 0
    maxWord = ""

    file = open(filename,encoding="utf8",errors='ignore')
    for line in file:
        words = re.findall(r"[\w']+|[.,!?;]", line)
        for i in range(0, len(words) - 1):
            lenInputWord = len(words[i])
            lenNextWord = len(words[i+1])
            if(lenInputWord > maxLengthWord):
                maxLengthWord = lenInputWord
                maxWord = words[i]
            elif(lenNextWord > maxLengthWord):
                maxLengthWord = lenNextWord
                maxWord = words[i+1]
            matrix.add_transition(lenInputWord,lenNextWord)
    return [maxLengthWord, maxWord]



# convert TransitionMatrix into a 2D array
# OUTPUT:
#   arr2    2D array representation of TransitionMatrix
def convertTo2D(tMatrix):
    tMatrix.normalize()
    arr = np.zeros((N,N))
    for key in tMatrix.norm_matrix:
        for nextKey in tMatrix.norm_matrix[key]:
            NumNextKey = tMatrix.norm_matrix[key][nextKey]
            arr[key-1][nextKey-1] = NumNextKey
    return arr

# Compare 2D arrays (transition matrices) via distance formulas and return distance.
# INPUT:
#   arr1    first transition matrix - result from convertTo2D
#   arr2    second transition matrix - result from convertTo2D
#   length  int of largest word length - used to make distanceMatrix best size.
# OUTPUT:
#   distance  result of distance comparison between the two transition matices
def compareMatrices(arr1, arr2):
    distanceMatrix = np.zeros((N,N))
    distance = 0
    for i in range(0,N):
        for j in range(0,N):
            distanceMatrix[i,j] = abs(arr1[i][j] - arr2[i][j]) # rounding to 2nd decimal point
            distance+= abs(arr1[i][j] - arr2[i][j]) # Abs value difference  
            #distance+= math.pow((arr1[i][j] - arr2[i][j]),2) # square root distance (1) square difference
    #return distance**(0.5) # square root distance (2) square root of total
    #print('\n'.join([''.join(['{:10}'.format("%.4f" % item) for item in row]) # Prints out distance matrix
    #  for row in distanceMatrix]))
    return distance

# General steps for creating transition matrix
# (1) init TransitionMatrix
# (2) load text file and get the length
# (3) convert matrix to 2D 

def getCentroid():
    maxLength = 0 # only useful for finding what the largest word length is (needed to determine N in later runs)
    maxWord = "" # bug checking - don't want repeat of greateststarofmyexistence ...
    distance = 0
    matrixArray = {}
    counter = 0
    for file in glob.glob("*.txt"):
        counter+=1
        matrixArray[file] = TransitionMatrix()
        lengthArr = loadTextFile(file, matrixArray[file])
        length = lengthArr[0]
        maxWord = lengthArr[1]
        arr = convertTo2D(matrixArray[file])
        maxLength = max(length, maxLength)
        #if(maxLength == length):
        #    print(maxWord)
        matrixArray[file] = arr
        #print("----  ARR {}  ----".format(counter))
        #print('\n'.join([''.join(['{:10}'.format("%.4f" % item) for item in row]) # Prints out distance matrix
        #      for row in arr]))
        #print("maxlength = ", maxLength)
        #print("-------")

    # compare matrices
    distanceMatrix = {}
    #print(maxLength)
    #print("----  DISTANCE  ----")
    for key in matrixArray:
        for key2 in matrixArray:
            if(key2 != key):
                distance = compareMatrices(matrixArray[key], matrixArray[key2])
                distanceMatrix["{} vs. {}".format(key,key2)] = distance

    #for key in distanceMatrix:
    #    print("{key:<50} {value:>10}".format(key=key,value="%.4f" %distanceMatrix[key]))
    #print("-------")

    #print("Distance between matrices =", distance) # prints out difference between arr1 and arr2

    centroid = np.zeros((N,N))
    for key in matrixArray:
        for i in range(0,N):
            for j in range(0,N):
                centroid[i][j]+= matrixArray[key][i][j]

    for i in range(0,N):
        for j in range(0,N):
            centroid[i][j] = centroid[i][j]/counter

    # PRINT OUT CENTROID MATRIX
    #print("----  CENTROID  ----")

    #print('\n'.join([''.join(['{:10}'.format("%.4f" % item) for item in row]) # Prints out distance matrix
    #     for row in centroid]))
    #print("-------")

    # COMPARE CENTROID WITH EACH TEXT MARKOV CHAIN TRANSITION MATRIX
    #for key in matrixArray:
    #    distance = compareMatrices(matrixArray[key], centroid)
    #    distanceMatrix["{} vs. CENTROID".format(key)] = distance
    #    print("{key:<50} {value:>10}".format(key="{} vs. CENTROID".format(key),value="%.4f" %distance))

    return centroid

centroidArray = {}

os.chdir('Sir Conan Doyle')
centroidDoyle = getCentroid()
centroidArray['Doyle'] = (centroidDoyle)

os.chdir('..')
os.chdir('Charles Dickens')
centroidDickens = getCentroid()
centroidArray['Dickens'] = (centroidDickens)

os.chdir('..')
os.chdir('Charles Darwin')
centroidDarwin = getCentroid()
centroidArray['Darwin'] = (centroidDarwin)



for key in centroidArray:
    for key2 in centroidArray:
        if key != key2:
            distance = compareMatrices(centroidArray[key], centroidArray[key2])
            print("{key:<50} {value:>10}".format(key="{} vs. {}".format(key,key2),value="%.4f" %distance))