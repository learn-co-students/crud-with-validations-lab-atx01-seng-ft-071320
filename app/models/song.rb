class Song < ApplicationRecord
    validates :title, presence: true
    validates :title, uniqueness: { scope: :release_year && :artist_name }
    validates :artist_name, presence: true
    validate :release_year_if_released
    validate :valid_release_year

    def release_year_if_released
        if released == true && release_year == nil
            errors.add(:release_year, "must exist if song has been released")
        end
    end

    def valid_release_year
        if released == true && release_year != nil && release_year > Time.now.year
            errors.add(:release_year, "can't be in the future")
        end
    end
end
