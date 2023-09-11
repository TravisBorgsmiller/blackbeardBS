class App < ApplicationRecord
    validates :name, presence: true
    validates :number, :presence => {:message => 'must enter valid phone number'}, :numericality => true, :length => { :minimum => 10, :maximum => 10 }
end
