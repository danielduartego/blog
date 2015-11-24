# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


tags = ["fashion", "photography", "food", "travel", "music", "sports"]

tags.each do |tag|
  Tag.create(name: tag)
end

print Cowsay::say("create #{tags.length} tags")
