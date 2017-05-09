# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'HTTParty'
require 'nokogiri'
require 'json'

url = 'https://api.github.com/organizations/8825476/repos?page='

def get_data(url)
  resp = HTTParty.get(url)
  resp.each do |repo|
    page_url = "https://github.com/#{repo['full_name']}"
    page = Nokogiri::HTML(open(page_url))
    if page.present?
      description = page.css('div#readme')
        .css('article').css('p')
        .first
      if description.present?
        description_text = description.text
      end
    end
    if repo["name"].present? && description_text.present?
      Lesson.create(
        name: repo["name"],
        description: description_text
        # url: page_url
      )
    end
  end
end

for i in 1..50
  get_data(url+i.to_s)
end
