# Ruby-Warrior-Game-Workshop

Ruby Object Oriented Battle Text Based Game in Terminal

It’s going to be a battle royale object oriented style! Provided is the outline for a Fighter class with the basic methods and attributes that your fighters should have. Finish the damage implementation for the attack method on Fighter. Finish implementing the take_damage method on Fighter. Create at least two unique subclasses of Fighter where you will add at least one custom attack method (It will output a different message and do a different amount of damage).

Create a game loop, similar to the text adventure where you instantiate two fighter subclasses. One of them will be the computer, and one will be player controlled. Each turn (or pass on the loop) will require an input from you from the terminal that asks which attack to use. Then it will perform that attack on the computer. Then the computer should attack you back. The game should proceed until someone runs out of life and the match winner is announced.

- class Fighter 
-  def initialize(name)
-    @name = name
-    @life = 10
-  end
-
-  def attack(fighter_instance)
-    puts "#{@name} is attacking #{fighter_instance.name}!" 
-    damage = #implement way to get random number of damage from 1-3
-    
-    fighter_instance.take_damage(damage)
-  end
-  
-  def take_damage(incoming_damage)
-    implement being attacked. Puts message that they are being attacked.  Remove equivalent amount of life from incoming attack
-  end

Bonus: Create unique abilities, such as a defend or power up ability. These can modify the attacks by either increasing or decreasing their power for the next turn(s).
