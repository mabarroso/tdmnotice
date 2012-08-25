class Follower < ActiveRecord::Base
  attr_accessible :follow, :id, :notified_at, :screen_name

  def self.not_exists?(ids)
    self.find(ids)
    false
  rescue
    true
  end

end
