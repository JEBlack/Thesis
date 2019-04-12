# Thesis
Matlab and data files for honors thesis project, which mostly consist of a connectionist model that learns to read. 

A Note:
This repository is mostly used as cloud storage, not as a way to share code between people. It can be a mess and is not 
updated regularly. 

That being said, there should be everything here (as of April 1) to construct the model and train it. 

To train a normal model to read, download all the files, including the training words spreadseet and the sheets that 
describe the distributed representations of the phonemes (phonRep, vRep, and cRep).

Run the matlab file called Network. This will train the network. When it's done you will have two weight matrices, W1 and W2.
It will also graph the percentage of words the model got right after each epoch, so you can watch it learn.

The architecture of the network: 

  Input is a 156 element vector. Within every 26 nodes, 1 node is turned on and 1 off. That on node represents the letter in 
  that slot. 
  Output is a 60 element vector. A phoneme is represented every 12 nodes-- its representation is distributed across 12 
  phonological feature nodes (e.g., consonantal, labial, etc). 
  
  To convert orthography into the input representation, use fOrth() function. Example: fOrth('cat')
  To convert phonology into output representation, use fPhon() function. Example: fPhon('K.AE.T'). note: must use IPHOD glyphs.
