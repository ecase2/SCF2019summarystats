* use mata to format excel better 
* THIS TAKES TOO LONG 

mata 
 b = xl()
 b.load_book("outputfiles/$mainvar.xlsx")
 
 x = b.get_sheets()
 b.set_sheet(x[2])
 b.set_column_width(1,6,13)
 
 b.set_sheet(x[3])
 b.set_column_width(1,6,13)
 
 b.set_sheet(x[4])
 b.set_column_width(1,6,13)
 
 b.set_sheet(x[5])
 b.set_column_width(1,6,13)
 
 b.set_sheet(x[6])
 b.set_column_width(1,6,13)
 
 b.set_sheet(x[7])
 b.set_column_width(1,6,13)
 
 b.set_sheet(x[8])
 b.set_column_width(1,6,13)
 
 b.set_sheet(x[9])
 b.set_column_width(1,6,13)
 
 b.set_sheet(x[10])
 b.set_column_width(1,6,13)
 
 b.set_sheet(x[11])
 b.set_column_width(1,6,13)
 
 b.set_sheet(x[12])
 b.set_column_width(1,6,13)
 
 b.set_sheet(x[13])
 b.set_column_width(1,6,13)
 
 b.set_sheet(x[14])
 b.set_column_width(1,6,13)
 
 b.set_sheet(x[15])
 b.set_column_width(1,6,13)
 
 b.close_book()
 end
