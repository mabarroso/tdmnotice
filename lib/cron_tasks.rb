# http://www.ibm.com/developerworks/library/os-dataminingrubytwitter/
module Cron
  class Tasks
	  def self.notify
	    followers = Cron::Followers.new
	    puts 'import new followers'
	    followers.import_new
	  end
  end

  class Followers
    def import_new max = 20
      cursor = "-1"
      # Loop through all pages
      while cursor != 0 do
        followers = Twitter.follower_ids(:screen_name,:cursor=>cursor)
        followers.ids.each do |fid|
          max-= 1 if (max > 0) && import_user_data(fid)
          cursor = 0 if max < 1
        end
        cursor = followers.next_cursor
      end
    end

    private
    def import_user_data id
      return false unless Follower.not_exists?(id)
      f = Twitter.user(id)
      Follower.create  id: id, screen_name: f.screen_name,
                       utc_offset: f.utc_offset, time_zone: f.time_zone, lang: f.lang,
                       following: f.following, follow_request_sent: f.follow_request_sent
      return true
    end
  end
end
