@lets_fight = true

def choose_player1
    puts ""
    puts "#{@player}, Choose Your Power"
    puts "Type: Brawler, Archer, Mage"
    puts ""
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    choice = gets.chomp.downcase
    if choice == 'brawler'
        @player = Brawler.new(@player)
    elsif choice == 'archer'
        @player = Archer.new(@player)
    elsif choice == 'mage'
        @player = Mage.new(@player)
    else
        choose_player1
    end
    choose_player2
end

def choose_player2
    puts ""
    puts "#{@player2}, Choose Your Power"
    puts "Type: Brawler, Archer, Mage"
    puts ""
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    choice = gets.chomp.downcase
    if choice == 'brawler'
        @player2 = Brawler.new(@player2)
    elsif choice == 'archer'
        @player2 = Archer.new(@player2)
    elsif choice == 'mage'
        @player2 = Mage.new(@player2)
    else
        choose_player2
    end
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts ""
    @player.is
    @player2.is
    puts ""
    player_turn
end

def player_turn
    puts "========================================================================"
    puts ""
    puts "#{@player.name} Press Enter For Attack"
    choice = gets.chomp.downcase
    puts "========================================================================"
    puts ""
    $damage = 0
    @player.choose
    puts ""
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    choice = gets.chomp.downcase
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts ""
    if choice == @player.attack1.downcase
        @player.attack_1    
    elsif choice == @player.attack2.downcase
        @player.attack_2
    elsif choice == @player.powerup.downcase
        @player.power_up
    else
        player_turn
    end
    @player2.hp -= $damage
    if @player2.hp < 1
        @player2.hp = 0
    end
    puts ""
    puts "#{@player2.name} has #{@player2.hp} HP"
    puts "#{@player.name} has #{@player.hp} HP"
    puts ""
    if @player.hp < 1 || @player2.hp < 1
        gameover
    else
        player2_turn
    end
end

def player2_turn
    puts "------------------------------------------------------------------------"
    puts ""
    puts "#{@player2.name} Press Enter For Attack"
    choice = gets.chomp.downcase
    puts "------------------------------------------------------------------------"
    puts ""
    $damage = 0
    @player2.choose
    puts ""
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    choice = gets.chomp.downcase
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts ""
    if choice == @player2.attack1.downcase
        @player2.attack_1    
    elsif choice == @player2.attack2.downcase
        @player2.attack_2
    elsif choice == @player2.powerup.downcase
        @player2.power_up
    else
        player2_turn
    end
    @player.hp -= $damage
    if @player.hp < 1
        @player.hp = 0
    end
    puts ""
    puts "#{@player2.name} has #{@player2.hp} HP"
    puts "#{@player.name} has #{@player.hp} HP"
    puts ""
    if @player.hp < 1 || @player2.hp < 1
        gameover
    else
        player_turn
    end
end

def gameover
    if @player.hp < 1
        puts " :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :) "
        puts "   :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)   "
        puts ""
        puts "#{@player2.name} Wins ||| #{@player.name} Loses"
        puts ""
        puts "   :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)   "
        puts " :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :) "
        puts ""
    elsif @player2.hp < 1
        puts " :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :) "
        puts "   :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)   "
        puts ""
        puts "#{@player.name} Wins ||| #{@player2.name} Loses"
        puts ""
        puts "   :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)   "
        puts " :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :) "
        puts ""
    end
    @lets_fight = false
end

class Fighter
    attr_accessor :hp
    attr_reader :name
    attr_reader :attack1
    attr_reader :attack2
    attr_reader :powerup

    def initialize(hp, name, attack1, attack2, powerup, powerup_ability)
        @hp = hp
        @name = name
        @attack1 = attack1
        @attack2 = attack2
        @powerup = powerup
        @powerup_ability = powerup_ability
    end

    def attack_1
        puts "#{name} Uses #{attack1} for #{$damage} Damage"
    end

    def attack_2
        puts "#{name} Uses #{attack2} for #{$damage} Damage"
    end
    
    def power_up
        puts "#{name} Uses #{powerup}"
    end

    def choose
        puts "#{@name} Choose: #{@attack1}, #{@attack2}, #{@powerup}"
    end
end

class Brawler < Fighter
    def initialize(name)
        super(100, name, 'Smash', 'Punch', 'Rage', false)
    end

    def attack_1
        $damage = 15 + rand(11)
        if @powerup_ability 
            self.hp += $damage / 2
            puts "#{name} leeches #{($damage / 2).to_s} HP"
        end
        @powerup_ability = false
        super
    end

    def attack_2
        $damage = 5 + rand(5..21)
        if @powerup_ability 
            self.hp += $damage / 2
            puts "#{name} leeches #{($damage / 2).to_s} HP"
        end
        @powerup_ability = false
        super
    end

    def power_up
        @powerup_ability = true
        super
    end

    def is
        puts "#{@name} is a Brawler with #{@hp} HP"
    end
end

class Archer < Fighter
    def initialize(name)
        super(100, name, 'Arrow', 'Fire arrow', 'Meditate', false)
    end
    
    def attack_1
        $damage = rand(3..7) * rand(3..7)
        @powerup_ability = false
        super
    end
    
    def attack_2
        $damage = rand(8..10) * rand(2..3)
        @powerup_ability = false
        super
    end

    def power_up
        @health = self.hp / 5
        if @health < 10
            @health *= rand(2..3)
        elsif @health < 5
            @health *= rand(2..5)
        end
        self.hp += @health
        puts "#{name} gains #{@health} HP"
        super
    end
    
    def is
        puts "#{@name} is a Archer with #{@hp} HP"
    end
end

class Mage < Fighter
    def initialize(name)
        super(100, name, 'Burn', 'Freeze', 'Conjure', false)
    end
    
    def attack_1
        $damage = rand(60..90) / rand(3..6)
        if @powerup_ability
            $damage *= 1.5
            puts "Conjure Adds %50 Damage"
        end
        @powerup_ability = false
        super
    end
    
    def attack_2
        $damage = rand(30..40) - rand(3..20)
        if @powerup_ability
            $damage = ($damage * 1.5).round
            puts "Conjure Adds %50 Damage"
        end
        @powerup_ability = false
        super
    end
    
    def power_up
        @powerup_ability = true
        self.hp += 5
        puts "#{name} gains 5 HP and adds %50 Damage Next Turn"
        super
    end

    def is
        puts "#{@name} is a Mage with #{@hp} HP"
    end
end

while @lets_fight == true
    puts "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    puts "RUBY FIGHTER"
    puts ""
    puts "Each fighter has 100 HP, 2 attacks, and 1 powerup"
    puts ""
    puts "Brawler: Smash, Punch, Rage"
    puts "Archer: Arrow, Blade Throw, Meditate"
    puts "Mage: Burn, Freeze, Conjure"
    puts ""
    puts "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    puts ""
    puts "Player 1: Enter Fighter Name"
    puts ""
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    choice = gets.chomp
    @player = choice
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts ""
    puts "Player 2: Enter Fighter Name"
    puts ""
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    choice = gets.chomp
    @player2 = choice
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    choose_player1
end