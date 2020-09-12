require 'nokogiri'
require 'open-uri'

document = Nokogiri::HTML(open('https://www.imdb.com/chart/top'))

table = document.css('table.chart').css('tbody.lister-list')

open('movies.csv', 'w') do |file|

    table.search('tr').each do |tr|
        title = tr.css('td.titleColumn').css('a').text
        rating = tr.css('td.ratingColumn').css('strong').text
        #puts title + ' ' + rating 
        file.puts %("#{title.chomp}";"#{rating.chomp}")
        next if tr['class'] == 'watchlistColumn'
    end

end
