require 'spreadsheet'

# create a new book and sheet

def get_years(line)

  unless line.split("!")[1] == "NAN"
    line.split("!")[1].split("/")[2]
  else
    "NAN"
  end
end

def get_index(sheet, nom_journal)

  index = 0
  vide = 0
  while sheet[0,index] != nom_journal

    if sheet[0,index] == nil
      vide +=1
    end
    if vide == 2
  index
      break
    end
    index +=1
  end
  index
end

def sort_in_spread()
  book = Spreadsheet::Workbook.new
  tab = {}
  annee = 0

  ordo = 0
  File.readlines("Le\ Havre\ libre").each do | line |   # $file
  absci = 0
  annee = get_years(line).to_s

    if tab[:"#{annee}"] == nil
      tab[:"#{annee}"] = book.create_worksheet
      tab[:"#{annee}"].name = annee
    end

    ordo = get_index(tab[:"#{annee}"], "Le\ Havre\ libre") #sera remplacé par $file

    unless tab[:"#{annee}"][ordo,absci] == "Le\ Havre\ libre"   #aussi remplacé par $file
       tab[:"#{annee}"][ordo,absci] = "Le\ Havre\ libre"   # $file
        absci +=1
        ordo +=1
    else
        ordo +=1
        absci +=1
    end

    while tab[:"#{annee}"][ordo,absci] != nil
      ordo +=1
    end

    date = line.split("!")[1]
    article = line.split("!")[0]
    url= line.split("!")[2].to_s
    
    tab[:"#{annee}"][ordo,absci] = date
    absci +=1
    tab[:"#{annee}"][ordo,absci] = article
    absci +=1
    tab[:"#{annee}"][ordo,absci] = url
  end
# save file
book.write 'test.xls'
end

sort_in_spread()
