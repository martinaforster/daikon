from nltk.tokenize import word_tokenize
import nltk

print(nltk.__version__)
files = ['dev.de', 'dev.en', 'train.de', 'train.en', 'test.de']
for f in files:
    input_file = f
    sentences = open(input_file, "r")  # opens file for reading
    preprocessedFileName = "preprocessed/"+input_file
    preprocessed = open(preprocessedFileName, "w")

    for sentence in sentences:
        tokens = word_tokenize(sentence)
        tokenized = " ".join(tokens)
        preprocessed.write(tokenized)
        preprocessed.write("\n")
    preprocessed.close()
