# Test Input:
card_public_key = 5764801
door_public_key = 17807724

# Real Input:
card_public_key = 3248366
door_public_key = 4738476

card_subject = door_subject = subject_number = 7

card_loop_size = nil
door_loop_size = nil

card_loop_size = 1
until card_subject == card_public_key
  card_subject = card_subject * subject_number
  card_subject = card_subject % 20201227
  card_loop_size += 1
end

puts card_loop_size

door_loop_size = 1
until door_subject == door_public_key
  door_subject = door_subject * subject_number
  door_subject = door_subject % 20201227
  door_loop_size += 1
end

puts door_loop_size

# Get encryption key
card_subject = door_public_key
(card_loop_size -1).times do
  card_subject = card_subject * door_public_key
  card_subject = card_subject % 20201227
end

puts card_subject
