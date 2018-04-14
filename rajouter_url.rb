require 'watir'
require 'pry'

browser = Watir::Browser.new :firefox
browser.driver.manage.timeouts.implicit_wait = 5

quot_search  = File.open("quotidien_Af", "r")

unless Dir.exist?("test")
  Dir.mkdir("test")
end

quot_search.each_with_index do | line,index |
  browser.goto 'google.com'
  sleep 3
  search_bar = browser.text_field(class: 'gsfi')
  sleep 3
  search_bar.set("site:" + line.split("!")[1] + " -pieton accident OR collision AND train" )
  sleep 3
  search_bar.send_keys(:enter)
  sleep 3
  recherche = browser.divs(class:"rc")
  date = browser.spans(class: "f")
  write_ls_url = File.open("test/#{index}#{line[0,(line.size - 1)].split("!")[0]}", 'a')
  for nb in 0...10
    (date[nb].exist?) ? dat = date[nb].text : dat = "NAN"
    if recherche[nb].exist?
    write_ls_url.write( recherche[nb].h3.text + "!" + dat  + "!"+recherche[nb].h3.a.href + "\n")
    end
  end
  sleep 3
end

browser.close







