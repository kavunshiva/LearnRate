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
# require 'net/http'

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
      learn_url_element = page.css('a').find {|element| element.to_html.include?("learn.co")}
      if learn_url_element.present?
        learn_url = learn_url_element['href'].split('//').last

        # full_learn_url = URI('https://' + learn_url)
        # full_learn_url = 'http://' + learn_url
        # req = Net::HTTP.request_head(full_learn_url)

        # uri = URI(full_learn_url)

        # new_thing = Net::HTTP.new(uri.host, uri.port)
        # new_thing.use_ssl = true

        # new_thing.start do |http|
          # response = ''
          # while !response.is_a?(Net::HTTPSuccess)
            # request = Net::HTTP::Get.new uri
            # response = http.request request # Net::HTTPResponse object
            # uri = URI(response.uri)
            # binding.pry
          # end
        # end

        # redirected_learn_uri_path = Net::HTTP.get_response(URI('https://'+learn_url))
        # .uri.path
      end
    end
    if repo["name"].present? &&
      description_text.present? &&
      learn_url.present?
        lesson = Lesson.create(
          name: repo["name"],
          description: description_text,
          url: learn_url,
          unit_location: "#{rand(100)}-#{rand(100)}-#{rand(100)}-#{rand(100)}"
        )
    end
  end
end

for i in 1..10
  get_data(url+i.to_s)
end
