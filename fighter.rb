@lets_fight = true

def choose_fighter
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
        choose_fighter
    end
    choose_enemy
end

def choose_enemy
    @enemy_fighter_number = rand(3)
    if @enemy_fighter_number == 0
        @enemy = Brawler.new(@enemy)
    end
    if @enemy_fighter_number == 1
        @enemy = Archer.new(@enemy)
    end
    if @enemy_fighter_number == 2
        @enemy = Mage.new(@enemy)
    end
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts ""
    @player.is
    @enemy.is
    puts ""
    player_turn
end

def player_turn
    puts "========================================================================"
    puts ""
    puts "Attack: #{@player.name} Press Enter"
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
    @enemy.hp -= $damage
    if @enemy.hp < 1
        @enemy.hp = 0
    end
    puts ""
    puts "#{@enemy.name} has #{@enemy.hp} HP"
    puts "#{@player.name} has #{@player.hp} HP"
    puts ""
    if @enemy.hp < 1
        winner
    else
        enemy_turn
    end
end

def enemy_turn
    puts "------------------------------------------------------------------------"
    puts ""
    puts "Defense: #{@player.name} Press Enter "
    choice = gets.chomp.downcase
    $damage = 0
    puts "------------------------------------------------------------------------"
    puts ""
    choice = rand(3)
    if choice == 0
        @enemy.attack_1
    elsif choice == 1
        @enemy.attack_2
    elsif choice == 2
        @enemy.power_up
    end
    @player.hp -= $damage
    if @player.hp < 1 
        @player.hp = 0
    end
    puts ""
    puts "#{@enemy.name} has #{@enemy.hp} HP"
    puts "#{@player.name} has #{@player.hp} HP"
    puts ""
    if @player.hp < 1
        loser
    else
        player_turn
    end
end

def winner
    puts " :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :) "
    puts "   :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)   "
    puts ""
    puts "#{@player.name} Wins"
    puts ""
    puts "   :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)   "
    puts " :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :)  :) "
    puts ""
    @lets_fight = false
end

def loser
    puts " :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :( "
    puts "   :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :(   "
    puts ""
    puts "#{@player.name} Loses"
    puts ""
    puts "   :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :(   "
    puts " :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :(  :( "
    puts ""
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
    puts "Enter Fighter Name"
    puts ""
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    choice = gets.chomp
    @player = choice
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts ""
    puts "Enter Name of Enemy"
    puts ""
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    choice = gets.chomp
    @enemy = choice
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    choose_fighter
end