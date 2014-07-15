require 'rest_client'
require 'json'

namespace :scraper do
  task :scrape => :environment do
    response = RestClient.get 'https://www.kimonolabs.com/api/ag1ehlu6?apikey=007efef198ac1a5867740a1ae9100fa4' 
    results = JSON.parse(response)
    # {"name"=>"soccermail", "count"=>6, "frequency"=>"realtime", "version"=>1, "newdata"=>false, "lastrunstatus"=>"success", "lastsuccess"=>"Tue Jul 15 2014 07:44:24 GMT+0000 (UTC)", "results"=>{"collection1"=>[{"date"=>"Sábado 19 Julio"}, {"date"=>"Domingo 20 Julio"}], "collection2"=>[{"competition"=>{"text"=>"Trofeo Colombino", "href"=>"http://www.futbolenlatele.com/indexf.php?comp=Trofeo Colombino"}, "home_team"=>"Recreativo Huelva", "away_team"=>"Barcelona", "channel"=>"TV3", "start_time"=>"22:00"}, {"competition"=>{"text"=>"Liga Brasileña", "href"=>"http://www.futbolenlatele.com/indexf.php?comp=Liga Brasileña"}, "home_team"=>"Atlético Mineiro", "away_team"=>"Bahia", "channel"=>"Canal + Fútbol", "start_time"=>"23:30"}, {"competition"=>{"text"=>"Amistoso", "href"=>"http://www.futbolenlatele.com/indexf.php?comp=Amistoso"}, "home_team"=>"Val d'Aran", "away_team"=>"Espanyol", "channel"=>"Esport 3", "start_time"=>"19:00"}, {"competition"=>{"text"=>"Liga Brasileña", "href"=>"http://www.futbolenlatele.com/indexf.php?comp=Liga Brasileña"}, "home_team"=>"Palmeiras", "away_team"=>"Cruzeiro", "channel"=>"Canal + Fútbol", "start_time"=>"21:00"}]}}
    results["results"]["collection2"].each do |line|
      competition = Competition.find_or_create_by name: line["competition"]["text"]
    end

    puts "We have #{Competition.count} competitions"
end
end
