require 'spreadsheet'

book = Spreadsheet::Workbook.new
index_line = 0
index_sheet = 1
sheet = book.create_worksheet
Dir.foreach("../result_sort") do | file |

  unless  file == '.' || file == '..'
    sheet[0, index_line] = file
    index_line += 1 

    FILE.readline("../result_sort/#{file}").each do | line |
      line_split = line.split("!")
      line_split.each_with_index do |part_line, nb_part|
        sheet[nb_part,  ] = 

      end
    end
  end



  # create a new book and sheet
  5.times do |j| 
    5.times do |i|
      if i == j
        sheet[j,i] = "coucou"
      elsif  i > j 
        sheet[j,i] = "coucou"
      else
        sheet[j,i] = (i+1)*10**j
      end
    end
  end
  # column

  sheet.column(2).outline_level = 1
  # row
  sheet.row(2).outline_level = 1
  sheet.row(3).outline_level = 1
  sheet.row(2).outline_level = 1
  sheet.row(3).outline_level = 1

  # save file
  book.write 'out.xls'

