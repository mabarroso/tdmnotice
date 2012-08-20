class Follower < ActiveRecord::Base
  attr_accessible :follow, :id, :notified_at, :screen_name
end
