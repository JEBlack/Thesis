# Thesis
Matlab and data files for honors thesis project, which mostly consist of a connectionist model that learns to read. 

A Note:
This repository is mostly used as cloud storage, not as a way to share code between people. It can be a mess and is not 
updated regularly. 

That being said, there should be everything here (as of April 1) to construct the model and train it. 

The Network file contains the simple network with minimal testing code tacked on.

The architecture of the network: 

  Input is a 156 element vector. Within every 26 nodes, 1 node is turned on and 1 off. That on node represents the letter in 
  that slot. 
  Output is a 60 element vector. A phoneme is represented every 12 nodes-- its representation is distributed across 12 
  phonological feature nodes (e.g., consonantal, labial, etc). 
  
  To convert orthography into the input representation, use fOrth() function. Example: fOrth('cat')
  To convert phonology into output representation, use fPhon() function. Example: fPhon('K.AE.T'). note: must use IPHOD glyphs.
