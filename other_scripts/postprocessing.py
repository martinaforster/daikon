from nltk.tokenize import word_tokenize
from nltk.tokenize.treebank import TreebankWordDetokenizer
import sys

if not len(sys.argv) == 3:
    print("Not enough arguments. Specify the file to postprocess and the file to save postprocessed sentences. ")
    exit(1)

twd = TreebankWordDetokenizer()
input_file_to_postprocess = sys.argv[1]
postprocessed_file = sys.argv[2]
sentences = open(input_file_to_postprocess, "r")  # opens file for reading
file = open(postprocessed_file, "w")

for sentence in sentences:
    tokens = word_tokenize(sentence)
    tokenized = " ".join(tokens)
    toks = word_tokenize(tokenized)
    detokenized = twd.detokenize(toks)
    capitalized = detokenized.capitalize()
    file.write(capitalized)
    file.write("\n")
file.close()




