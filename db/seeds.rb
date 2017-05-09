# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'HTTParty'

url = 'https://api.github.com/organizations/8825476/repos?page='

def get_data(url)
  resp = HTTParty.get(url)
  resp.each do |repo|
    Lesson.create(name: repo["name"])
  end
end

for i in 1..50
  get_data(url+i.to_s)
end
