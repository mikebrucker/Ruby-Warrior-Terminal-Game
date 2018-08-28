require 'rainbow'
@lets_fight = true

def choose_player1
    puts ""
    puts Rainbow("#{@player}").cyan + ", Choose Your Power"
    puts Rainbow("Type: Brawler, Archer, Mage").purple
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
    puts Rainbow("#{@player2}").cyan + ", Choose Your Power"
    puts Rainbow("Type: Brawler, Archer, Mage").purple
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
    player_hp
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
    player_hp
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

def player_hp
    @player.hp < 25 ? puts(Rainbow("#{@player.name}").cyan + " has " + Rainbow("#{@player.hp} HP").red) : puts(Rainbow("#{@player.name}").cyan + " has " + Rainbow("#{@player.hp} HP").green)
    @player2.hp < 25 ? puts(Rainbow("#{@player2.name}").cyan + " has " + Rainbow("#{@player2.hp} HP").red) : puts(Rainbow("#{@player2.name}").cyan + " has " + Rainbow("#{@player2.hp} HP").green)
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
        puts Rainbow("#{name}").cyan + " Uses " + Rainbow("#{attack1}").darkred + " for " + Rainbow("#{$damage}").red + " Damage"
    end

    def attack_2
        puts Rainbow("#{name}").cyan + " Uses " + Rainbow("#{attack2}").darkred + " for " + Rainbow("#{$damage}").red + " Damage"
    end
    
    def power_up
        puts Rainbow("#{name}").cyan + " Uses " + Rainbow("#{powerup}").blue
    end

    def choose
        puts Rainbow("#{name}").cyan + " Choose: " + Rainbow("#{@attack1}, #{@attack2}, #{@powerup}").orangered
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
            puts Rainbow("#{name} leeches #{($damage / 2).to_s} HP").green
        end
        @powerup_ability = false
        super
    end

    def attack_2
        $damage = 5 + rand(5..21)
        if @powerup_ability 
            self.hp += $damage / 2
            puts Rainbow("#{name} leeches #{($damage / 2).to_s} HP").green
        end
        @powerup_ability = false
        super
    end

    def power_up
        @powerup_ability = true
        puts Rainbow("Next attack will leech half damage done").indianred
        super
    end

    def is
        puts Rainbow("#{@name} is a Brawler with #{@hp} HP").firebrick
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
        puts Rainbow("#{@name} is an Archer with #{@hp} HP").seagreen
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
        puts Rainbow("#{@name} is a Mage with #{@hp} HP").dodgerblue
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