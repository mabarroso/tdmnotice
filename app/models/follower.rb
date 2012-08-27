class Follower < ActiveRecord::Base
  attr_accessible :follow_request_sent, :following, :id, :lang, :notified_at, :screen_name, :time_zone, :utc_offset

  scope :no_es, where('lang <> ? and notified_at is null', 'es')

  def self.not_exists?(ids)
    self.find(ids)
    false
  rescue
    true
  end
end
