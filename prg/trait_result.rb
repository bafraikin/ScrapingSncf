
def mois_to_i(mois)
  case mois
  when "déc."
    mois = "12"
  when "avr."
    mois = "04"
  when "mars"
    mois = "03"
  when "janv."
    mois = "01"
  when "nov."
    mois = "11"
  when "sept."
    mois = "09"
  when "juil."
    mois = "07"
  when "juin"
    mois = "06"
  when "mai"
    mois = "05"
  when "oct."
    mois = "10"
  when "août"
    mois = "08"
  when "févr."
    mois = "02"
  end
  mois
end

def time_set(line)
  line_split = line.split("!")[1]
  unless line_split == "NAN" 
    if line_split[0,6] == "Il y a" 
      time = Time.new
      tmp = time.strftime("%d").to_i - line_split[7,1].to_i  
      line_split = "%02d" %tmp.to_s + "/" + time.strftime("%m/%Y")

    else
      array_line = line_split.split
      line_split = "%02d" %array_line[0] + "/" + mois_to_i(array_line[1]) + "/" + array_line[2]
    end
  end
 line_split
end

def found_word(ouane_line, word)

  count = 0
  index = 0
  tmp = 0
  ouane_line = ouane_line.downcase.split("")
  word = word.split("")
  while index < ouane_line.size
    for nbr in 0...word.size
      if nbr == (word.size - 1) && word[nbr] == ouane_line[index]
        count +=1
      end
      if word[nbr] == ouane_line[index]
        index +=1
        next
      else
        break
      end
    end
    tmp +=1
    index = tmp
  end
  count
end

def suppr_line(line,dictionary)
  bool = true
  dictionary.each do | word |
    if found_word(line, word) != 0
      bool = false
    end
  end
  return bool
end

def sort_dir(dir, dicto)

  Dir.foreach(dir) do | file |
    puts file
    unless Dir.exist?("result_sort")
      Dir.mkdir("result_sort")
    end
    unless file == '.' || file == '..'
      arr_fil = File.readlines("#{dir}/#{file}")
      unless File.exist? ("result_sort/#{file}")
      File.new("result_sort/#{file}", 'w')
      end       
      new_file = File.open("result_sort/#{file}", 'a')
      arr_fil.each do | line |
        line_split = line.split("!")[0]
        if suppr_line(line_split, dicto)
          new_file.write(line_split + "!" + time_set(line) + "!" + line.split("!")[2])
          puts time_set(line)
        else
                  puts line
        end
      end
    File.delete("#{dir}/#{file}")  
    end
  end
  Dir.rmdir(dir)
end

classic_dictionary = ["états-unis", "etat-unis", "americaine", "américaine", "italie", "suisse", "angleterre", "belgique", "espagne", "portugal"]

sort_dir("result_to_sort" ,classic_dictionary)
