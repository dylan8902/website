class BingoGame
    attr_reader :numbers
    attr_writer :numbers

    class Number
        attr_reader :number, :phrases

        def initialize number, phrases, songs
            @number = number
            @phrases = phrases
            @songs = songs
        end

        def to_s
            "#{self.number}"
        end

        def phrase
            "#{self.phrases.sample}"
        end
    end


    NUMBERS = [
        Number.new( 1, [ "Kelly's Eye" ], ["Hit me baby one more time!"]),
        Number.new( 2, [ "" ], [""]),
        Number.new( 3, [ "" ], [""]),
        Number.new( 4, [ "" ], [""]),
        Number.new( 5, [ "" ], [""]),
        Number.new( 6, [ "" ], [""]),
        Number.new( 7, [ "" ], [""]),
        Number.new( 8, [ "" ], [""]),
        Number.new( 9, [ "" ], [""]),
        Number.new(10, [ "" ], [""]),
        Number.new(11, [ "" ], [""]),
        Number.new(12, [ "" ], [""]),
        Number.new(13, [ "" ], [""]),
        Number.new(14, [ "" ], [""]),
        Number.new(15, [ "" ], [""]),
        Number.new(16, [ "" ], [""]),
        Number.new(17, [ "" ], [""]),
        Number.new(18, [ "" ], [""]),
        Number.new(19, [ "" ], [""]),
        Number.new(20, [ "" ], [""]),
        Number.new(21, [ "" ], [""]),
        Number.new(22, [ "" ], [""]),
        Number.new(23, [ "" ], [""]),
        Number.new(24, [ "" ], [""]),
        Number.new(25, [ "" ], [""]),
        Number.new(26, [ "" ], [""]),
        Number.new(27, [ "" ], [""]),
        Number.new(28, [ "" ], [""]),
        Number.new(29, [ "" ], [""]),
        Number.new(30, [ "" ], [""]),
        Number.new(31, [ "" ], [""]),
        Number.new(32, [ "" ], [""]),
        Number.new(33, [ "" ], [""]),
        Number.new(34, [ "" ], [""]),
        Number.new(35, [ "" ], [""]),
        Number.new(36, [ "" ], [""]),
        Number.new(37, [ "" ], [""]),
        Number.new(38, [ "" ], [""]),
        Number.new(39, [ "" ], [""]),
        Number.new(40, [ "" ], [""]),
        Number.new(41, [ "" ], [""]),
        Number.new(42, [ "" ], [""]),
        Number.new(43, [ "" ], [""]),
        Number.new(44, [ "" ], [""]),
        Number.new(45, [ "" ], [""]),
        Number.new(46, [ "" ], [""]),
        Number.new(47, [ "" ], [""]),
        Number.new(48, [ "" ], [""]),
        Number.new(49, [ "" ], [""]),
        Number.new(50, [ "" ], [""]),
        Number.new(51, [ "" ], [""]),
        Number.new(52, [ "" ], [""]),
        Number.new(53, [ "" ], [""]),
        Number.new(54, [ "" ], [""]),
        Number.new(55, [ "" ], [""]),
        Number.new(56, [ "" ], [""]),
        Number.new(57, [ "" ], [""]),
        Number.new(58, [ "" ], [""]),
        Number.new(59, [ "" ], [""]),
        Number.new(60, [ "" ], [""]),
        Number.new(61, [ "" ], [""]),
        Number.new(62, [ "" ], [""]),
        Number.new(63, [ "" ], [""]),
        Number.new(64, [ "" ], [""]),
        Number.new(65, [ "" ], [""]),
        Number.new(66, [ "" ], [""]),
        Number.new(67, [ "" ], [""]),
        Number.new(68, [ "" ], [""]),
        Number.new(69, [ "" ], [""]),
        Number.new(70, [ "" ], [""]),
        Number.new(71, [ "" ], [""]),
        Number.new(72, [ "" ], [""]),
        Number.new(73, [ "" ], [""]),
        Number.new(74, [ "" ], [""]),
        Number.new(75, [ "" ], [""]),
        Number.new(76, [ "" ], [""]),
        Number.new(77, [ "" ], [""]),
        Number.new(78, [ "" ], [""]),
        Number.new(79, [ "" ], [""]),
        Number.new(80, [ "" ], [""]),
        Number.new(81, [ "" ], [""]),
        Number.new(82, [ "" ], [""]),
        Number.new(83, [ "" ], [""]),
        Number.new(84, [ "" ], [""]),
        Number.new(85, [ "" ], [""]),
        Number.new(86, [ "" ], [""]),
        Number.new(87, [ "" ], [""]),
        Number.new(88, [ "" ], [""]),
        Number.new(89, [ "" ], [""]),
        Number.new(90, [ "" ], [""])
    ]

    def initialize
      @numbers = NUMBERS.shuffle
    end


end
