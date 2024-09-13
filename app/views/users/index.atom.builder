xml.feed do |feed|
  feed.title "Users"
  @users.each do |user|
    feed.entry  do |entry|
      feed.title user.first_name + " " + user.last_name
      feed.content user.email
    end
  end
end