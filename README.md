pixdb
=====

storing data in gifs


use 
	perl pixdb_loader.pl wordlistfile 

to create a gifdb file

	perl pixdb_reader.pl 

to read the file


wordlist.txt is given as a starting point with 100k words from twitter


pixdb_loader creates 3 files, testpng.gif testpng.jpg and testpng.png.  Only testpng.png is being used right now

Uses GD module for perl
images are set in truecolor

Change $h to set max rows
Change $totalCols to total desired columns
Change $size to set the size of the field

Max fields is $h * $totalCols
