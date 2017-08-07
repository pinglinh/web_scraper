require "HTTParty"
require "Nokogiri"
require "JSON"
require "Pry"
require "csv"

page = HTTParty.get("https://newyork.craigslist.org/search/pet")

parse_page = Nokogiri::HTML(page)

pets_array = []

parse_page.css(".content").css(".result-row").css(".hdrlnk").map do |a|
  post_name = a.text
  pets_array.push(post_name)
end

CSV.open("pets.csv", "w") do |csv|
  pets_array.each do |pet|
    csv << [pet]
  end
end
