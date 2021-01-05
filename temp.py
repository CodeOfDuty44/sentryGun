import h5py
import numpy as np
from PIL import Image  
import matplotlib.pyplot as plt
import math
import random
import os

# Load Glove vectors
glove_dir = '../../storage/glove'
embeddings_index = {} # empty dictionary
# f = open(os.path.join(glove_dir, 'glove.42B.300d.txt'), encoding="utf-8")
f = open( 'glove.42B.300d.txt', encoding="utf-8")

for line in f:
    values = line.split()
    word = values[0]
    coefs = np.asarray(values[1:], dtype='float32')
    embeddings_index[word] = coefs
f.close()
print('Found %s word vectors.' % len(embeddings_index))