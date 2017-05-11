require 'HTTParty'
require 'nokogiri'
require 'json'

url = 'https://api.github.com/organizations/8825476/repos?page='
number_of_repo_pages_from_which_to_create_lessons = 10

def create_lessons(url)
  resp = HTTParty.get(url)
  resp.each do |repo|
    description, learn_url = get_description_and_url_from_json(repo)

    if repo["name"].present? &&
      description.present? &&
      learn_url.present?
        Lesson.create(
          name: repo["name"],
          description: description,
          url: learn_url,
          # kludge because numbers are arbitrary and scraping's a rabbit hole
          unit_location: "#{rand(100)}-#{rand(100)}-#{rand(100)}-#{rand(100)}"
        )
    end
  end
end

def get_description_and_url_from_json(json)
  page_url = "https://github.com/#{json['full_name']}"
  page = Nokogiri::HTML(open(page_url))
  if page.present?
    get_description_and_url_from_page(page)
  else
    [nil, nil]
  end
end

def get_description_and_url_from_page(page)
  description = get_description_from_page(page)
  learn_url = get_learn_url_from_page(page)
  [description, learn_url]
end

def get_description_from_page(page)
  description = page.css('div#readme')
    .css('article').css('p')
    .first
  if description.present?
    description.text
  end
end

def get_learn_url_from_page(page)
  learn_url_element = page.css('a').find do |element|
    element.to_html.include?("learn.co")
  end
  if learn_url_element.present?
    learn_url_element['href'].split('//').last
  end
end

def create_lessons_from_n_pages_of_repos(url, n)
  for i in 1..n
    create_lessons(url+i.to_s)
  end
end

create_lessons_from_n_pages_of_repos(
  url,
  number_of_repo_pages_from_which_to_create_lessons
)
