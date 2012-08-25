# http://www.ibm.com/developerworks/library/os-dataminingrubytwitter/
module Cron
  class Tasks
	  def self.notify
	    puts 'not implemented'
	    followers = Cron::Followers.new
	    followers.import_new
	  end
  end

  class Followers
    def import_new max = 5
      cursor = "-1"
      # Loop through all pages
      while cursor != 0 do
        followers = Twitter.follower_ids(:screen_name,:cursor=>cursor)
        followers.ids.each do |fid|
          if (max > 0 ) && Follower.not_exists?(fid)
            import_user_data fid
            max-= 1
          end
          cursor = 0 if max < 1
        end
        cursor = followers.next_cursor
      end
    end

    private
    def import_user_data id
      f = Twitter.user(id)
      Follower.create  id: id, screen_name: f.screen_name,
                       utc_offset: f.utc_offset, time_zone: f.time_zone, lang: f.lang,
                       following: f.following, follow_request_sent: f.follow_request_sent
    end
  end
end
