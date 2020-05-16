class BingoGame < ApplicationRecord

    class Number
        attr_reader :number, :instruction, :songs

        def initialize number, instruction, songs
            @number = number
            @instruction = instruction
            @songs = songs
        end

        def to_s
            "#{self.number}"
        end

    end


    NUMBERS = [
        Number.new( 1, "Kelly's Eye",       "Hit me baby one more time!"),
        Number.new( 2, "One little duck",   ""),
        Number.new( 3, "Cup of tea", "http://127.0.0.1:8080/Various%20Artists/Ultimate%20Party%20Animal%20Album%20Di/08%20Macarena%20_Bayside%20Boys%20Mix_.mp3"),
        Number.new( 4, "Knock at the door", ""),
        Number.new( 5, "Mambo", "http://127.0.0.1:8080/Lou%20Bega%20-%20Mambo%20%235%20(1999).mp3"),
        Number.new( 6, "Half a dozen", ""),
        Number.new( 7, "Lucky for some",    "http://127.0.0.1:8080/Various%20Artists/Now_%20Vol_%2044%20_UK_%20Disc%202/09%20S%20Club%20Party.mp3"),
        Number.new( 8, "", ""),
        Number.new( 9, "", ""),
        Number.new(10, "Boris' Den", ""),
        Number.new(11, "Legs Eleven", ""),
        Number.new(12, "", ""),
        Number.new(13, "Unlucky for some", "http://127.0.0.1:8080/Daft%20Punk%20feat_%20Pharrell%20Willi/Get%20Lucky/01%20Get%20Lucky%20Radio%20Edit.mp3"),
        Number.new(14, "", ""),
        Number.new(15, "", "http://127.0.0.1:8080/Unknown/Clarkson%20Rocks/04%20Teenage%20Dirtbag.mp3"),
        Number.new(16, "", ""),
        Number.new(17, "Dancing Queen", ""),
        Number.new(18, "", ""),
        Number.new(19, "", ""),
        Number.new(20, "", ""),
        Number.new(21, "", ""),
        Number.new(22, "Two little ducks", ""),
        Number.new(23, "", ""),
        Number.new(24, "", ""),
        Number.new(25, "", ""),
        Number.new(26, "", "http://127.0.0.1:8080/Various%20Artists/50%20Years%20of%20the%20Greatest%20Hit%20S/10%20The%20Grease%20Mega%20Mix.mp3"),
        Number.new(27, "", ""),
        Number.new(28, "", ""),
        Number.new(29, "Rise and Shine", "http://127.0.0.1:8080/The%20Killers/Hot%20Fuss/02%20Mr%20Brightside.mp3"),
        Number.new(30, "", ""),
        Number.new(31, "Happy Birthday", ""),
        Number.new(32, "Didgeridoo", ""),
        Number.new(33, "", ""),
        Number.new(34, "", ""),
        Number.new(35, "", ""),
        Number.new(36, "", ""),
        Number.new(37, "", ""),
        Number.new(38, "", "/Various Artists/Massive Dance 1999_ Vol_ 2 Dis/06 Praise You.mp3"),
        Number.new(39, "", ""),
        Number.new(40, "", ""),
        Number.new(41, "", ""),
        Number.new(42, "", "http://127.0.0.1:8080/Various%20Artists/Massive%20Dance%201999_%20Vol_%202%20Dis/06%20Praise%20You.mp3"),
        Number.new(43, "", ""),
        Number.new(44, "Find a fork", ""),
        Number.new(45, "", ""),
        Number.new(46, "", ""),
        Number.new(47, "", ""),
        Number.new(48, "", ""),
        Number.new(49, "", ""),
        Number.new(50, "", ""),
        Number.new(51, "Craig David", "http://127.0.0.1:8080/Various%20Artists/Now_%20Vol_%2045%20_UK_%20Disc%202/04%20Re-Rewind%20When%20the%20Crowd%20Say%20B.mp3"),
        Number.new(52, "", ""),
        Number.new(53, "", ""),
        Number.new(54, "", ""),
        Number.new(55, "", ""),
        Number.new(56, "", ""),
        Number.new(57, "", ""),
        Number.new(58, "", ""),
        Number.new(59, "", ""),
        Number.new(60, "", ""),
        Number.new(61, "", ""),
        Number.new(62, "", ""),
        Number.new(63, "", ""),
        Number.new(64, "", ""),
        Number.new(65, "", "http://127.0.0.1:8080/Cascada/Clubland%20Classix/01%20Every%20Time%20We%20Touch.mp3"),
        Number.new(66, "", ""),
        Number.new(67, "", ""),
        Number.new(68, "", ""),
        Number.new(69, "", "http://127.0.0.1:8080/Bryan%20Adams/The%20Best%20of%20Me/04%20Summer%20of%20'69.mp3"),
        Number.new(70, "", ""),
        Number.new(71, "Bang on the drum", ""),
        Number.new(72, "", ""),
        Number.new(73, "", ""),
        Number.new(74, "", ""),
        Number.new(75, "", "http://127.0.0.1:8080/Queen/Greatest%20Hits%20vol%201/00%20Bohemian%20Rapsody.mp3"),
        Number.new(76, "", ""),
        Number.new(77, "", "http://127.0.0.1:8080/The%20Libertines/Don't%20Look%20Back%20Into%20The%20Sun/01%20Don't%20Look%20Back%20Into%20The%20Sun.mp3"),
        Number.new(78, "", ""),
        Number.new(79, "", ""),
        Number.new(80, "", ""),
        Number.new(81, "", ""),
        Number.new(82, "", ""),
        Number.new(83, "", ""),
        Number.new(84, "", "http://127.0.0.1:8080/Michael%20Jackson/King%20Of%20Pop/03%20Thriller.mp3"),
        Number.new(85, "Stayin alive", ""),
        Number.new(86, "", ""),
        Number.new(87, "", ""),
        Number.new(88, "Two fat ladies", ""),
        Number.new(89, "", ""),
        Number.new(90, "", "")
    ]

    def next
        return nil if self.index > self.numbers.size
        new_index = self.index + 1
        self.update({
            index: new_index,
            current_number: numbers[new_index].to_json
        })
        return self.current_number
    end

    def numbers
        JSON.parse read_attribute(:numbers)
    end

    def current_number
        return nil if read_attribute(:current_number).nil?
        JSON.parse read_attribute(:current_number)
    end

    def self.prepare
        BingoGame.create(numbers: NUMBERS.shuffle.to_json, index: -1, current_number: nil)
    end

end
