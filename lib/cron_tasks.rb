# http://www.ibm.com/developerworks/library/os-dataminingrubytwitter/
module Cron
  class Tasks
	  def self.notify
	    puts 'not implemented'
	    #Twitter.friends.each do |follower|
	    #  puts "#{follower} "
	    #end

      cursor = "-1"
      # Loop through all pages
      while cursor != 0 do
        # Iterate followers, hash their location
        followers = Twitter.follower_ids(:screen_name, :cursor=>cursor)

        followers.ids.each do |fid|
          puts fid
          f = Twitter.user(fid)
          puts f.screen_name
          #loc = f.time_zone.to_s
          #if (loc.length > 0)
          #  if tweetlocation.has_key?(loc)
          #    tweetlocation[loc] = tweetlocation[loc] + 1
          #  else
          #    tweetlocation[loc] = 1
          #  end
          #  timezones = timezones + 1.0
          #end
        end
        cursor = followers.next_cursor
      end
	  end
  end
end
