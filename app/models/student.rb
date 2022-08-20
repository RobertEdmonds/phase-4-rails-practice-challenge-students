class Student < ApplicationRecord
    belongs_to :instructor 

    validates :name, presence: true
    validates :age, numericality: {greater_than: 18}
    validate :check_instructor_id

    def check_instructor_id
        check = Instructor.find(instructor_id)
        if check == false
            errors.add(:instructor_id, "Indtructor Not Found")
        end
    end


end
