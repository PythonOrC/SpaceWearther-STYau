def dictionary_sorter(dictionary, key):
    return sorted(dictionary, key=lambda k: dictionary[k][key])