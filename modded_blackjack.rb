def initial_cards
  suit = ["Spades", "Clubs", "Diamonds", "Hearts"]
  cards = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]
  $deck = suit.product(cards)
  
  $players_cards = []
  $dealers_cards = []
  $player_total = 0
  $dealer_total = 0

  $deck.shuffle!
  $players_cards.push($deck.pop)
  $dealers_cards.push($deck.pop)
  $players_cards.push($deck.pop)
  $dealers_cards.push($deck.pop)

  $player_total = calculate_total($players_cards)
  $dealer_total = calculate_total($dealers_cards)

  puts "You have drawn the #{$players_cards[0][1]} of #{$players_cards[0][0]} and the #{$players_cards[1][1]} of #{$players_cards[1][0]} for a total of #{$player_total}"
  puts ""
  puts "The dealer has drawn the #{$dealers_cards[0][1]} of #{$dealers_cards[0][0]} and the #{$dealers_cards[1][1]} of #{$dealers_cards[1][0]} for a total of #{$dealer_total}"
end

def calculate_total(cards)
  prev_ace = 0
  face_card = 10
  ace = 11
  additional_ace = 1
  total = 0

  cards.each do |c|
    if c[1] == "Jack"
      total = total + 10
    elsif c[1] == "Queen"
      total = total + 10
    elsif c[1] == "King"
      total = total + 10
    elsif c[1] == "Ace"
      if prev_ace >= 1
        total = total + additional_ace
      else
        total = total + ace
        prev_ace = prev_ace + 1
      end
    else
      total = total + c[1].to_i
    end
  end
  total
end

def hit_player
  $players_cards.unshift($deck.pop)
  $player_total = calculate_total($players_cards)
  puts "You have drawn card #{$players_cards[0][1]} of #{$players_cards[0][0]}"
  puts "Your new total is #{$player_total}"
  puts ""
end

def hit_dealer
  $dealers_cards.unshift($deck.pop)
  $dealer_total = calculate_total($dealers_cards)
  puts "The dealer has drawn the #{$dealers_cards[0][1]} of #{$dealers_cards[0][0]}"
  puts "The dealer's new total is #{$dealer_total}"
  puts ""
end

def dealing
  print "Dealing"
  deal = 1
  while deal < 10
    print "."
    deal = deal + 1
    sleep(0.2)
  end
end

def play_again?
  while true
    puts "Would you like to play again? yes or no"
    answer = gets.chomp.downcase
    
    if answer.eql?("yes") || answer.eql?("no")
      break
    else
      puts "Try Again"
    end
  end
  answer
end

puts "Welcome to the blackjack game"
puts ""
puts "What is your name?"
name = gets.chomp.downcase
puts "Alright #{name} lets play!"
puts ""
won = false
bust = false
stay = false

while true
  dealing

  puts ""

  initial_cards

  while true
    hit_or_stay = ""
    if $player_total > 21
      puts "You busted"
      bust = true
      break
    elsif $dealer_total > 21
      puts "You won!"
      puts "Dealer busted"
      won = true
      break
    elsif $player_total == 21
      puts "You won!"
      won = true
      break
    elsif $dealer_total == 21
      puts "You lost, the dealer has 21"
      bust = true
      break
    else
      bust = false
      won = false
    end

    if $player_total <= $dealer_total || $player_total <= 21
      puts "Would you like to hit or stay?"
      hit_or_stay = gets.chomp.downcase
      if hit_or_stay == "hit"
        hit_player
        next
      elsif hit_or_stay == "stay"
        puts "Ok, the dealer will now draw"
        break
      end
    end
  end
  
  if bust == true
    ans = play_again?
      if ans.eql?("yes")
        $deck.clear
        next
      else
        puts "Great Game!"
        exit
      end
  elsif won == true
    ans = play_again?
      if ans.eql?("yes")
        $deck.clear
        next
      else
        puts "Great Game!"
        exit
      end
  end


  puts ""
  while true
    if $player_total > $dealer_total
      hit_dealer
        if $dealer_total > 21
          puts "You won!"
          ans = play_again?
          if ans.eql?("yes")
            $deck.clear
            break
          else
            puts "Great Game!"
            exit
          end
        elsif $dealer_total > $player_total and $dealer_total <= 21
          puts "You lost"
          ans = play_again?
            if ans.eql?("yes")
              $deck.clear
              break
            else
              puts "Great Game!"
              exit
            end
        elsif $dealer_total < $player_total
          next
        end
    elsif $dealer_total == $player_total
      hit_dealer
        if $dealer_total > $player_total and $dealer_total <= 21
          puts "You lost"
          ans = play_again?
            if ans.eql?("yes")
              $deck.clear
              break
            else
              puts "Great Game!"
              exit
            end
        elsif $dealer_total > 21
          puts "You won!"
          ans = play_again?
          if ans.eql?("yes")
            $deck.clear
            break
          else
            puts "Great Game!"
            exit
          end
        end
    end
  end
end

      
    
  


