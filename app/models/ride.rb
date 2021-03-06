class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    if self.user.tickets < self.attraction.tickets && self.user.height < self.attraction.min_height 
      "Sorry. You do not have enough tickets to ride the #{self.attraction.name}. You are not tall enough to ride the #{self.attraction.name}."
    elsif self.user.height < self.attraction.min_height
      "Sorry. You are not tall enough to ride the #{self.attraction.name}." 
    elsif self.user.tickets < self.attraction.tickets
      "Sorry. You do not have enough tickets to ride the #{self.attraction.name}."
    else 
      update_happiness
      update_nausea
      update_tickets
      "Thanks for riding the #{self.attraction.name}!"
    end
  end 

  private 

  def update_tickets
    self.user.tickets -= self.attraction.tickets
    self.user.save
  end 

  def update_nausea 
    self.user.nausea += self.attraction.nausea_rating
    self.user.save
  end 

  def update_happiness 
    self.user.happiness += self.attraction.happiness_rating 
    self.user.save 
  end 
end
