require 'twitter'

config = {
	:consumer_key => 'DobOnYsBxhupb4tWtkIkud2nY',
	:consumer_secret => 'rNFlJpJv0b0gSYtrzgKfKcyEMM2L6AtwgsHgv3WIuqg6InXq8w',
	:access_token => '1092444312430919681-5lkYoGwZcwwDZbzoGUbZwtRQ1ISZV8',
	:access_token_secret => '78VHTUvHE4B7OO8Tv6xHYkkkuE4rWqB0bdGjcpNUYvleh'
}

client = Twitter::REST::Client.new(config)
client.update('This is Tom3 sending an automated tweet using Ruby')
