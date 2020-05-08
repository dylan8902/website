class BingoTicket
    attr_reader :rows

    def initialize
        @rows = [
            [ g(1..3), "        ", "       ", "       ", g(40..49), "       ", g(60..62), g(70..74), g(80..85) ],
            [ g(4..6), "        ", g(21..30), g(31..39), "       ", g(50..54), g(63..67), g(75..80), "       " ],
            [ g(7..10), g(11..20), "       ", "       ", "       ", g(55..60), g(68..70), "       ", g(86..90) ]
        ]
    end

    def g range
        range.to_a.sample(1).first
    end

end
