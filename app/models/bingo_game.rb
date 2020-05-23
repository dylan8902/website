class BingoGame < ApplicationRecord

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

    def future_numbers
        return self.numbers if self.index < 0
        self.numbers.from(self.index + 1)
    end

    def past_numbers
        return [] if self.index < 0
        self.numbers.to(self.index).reverse
    end

    def current_number
        return nil if read_attribute(:current_number).nil?
        JSON.parse read_attribute(:current_number)
    end

    def to_json(options)
        super(only: [:current_number], methods: [:future_numbers, :past_numbers])
    end

end
