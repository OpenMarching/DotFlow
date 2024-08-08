extends Node

## Generates a random string with a given length. NOT guarenteed to be unique, but is good enough.
func generate_random_string(length):
	var _random = RandomNumberGenerator.new()
	var library = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'
	var word = ""
	var chars = len(library)
	for i in range(length):
		word += library[randi() % chars]
	return word
