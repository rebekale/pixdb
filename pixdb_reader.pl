use GD;
$file = $ARGV[0] || 'testpng.png';
$img = new GD::Image->newFromPng($file,1);
$img->interlaced('true');
my ($w,$h) = $img->getBounds();

if (!$ARGV[0]) {
  #usage();
}
my $header = $img->getPixel(0,0);
my ($totalCols,$size,$maxRows) = $img->rgb($header);
$size = chr($size);

#$size = 1 + int($size / 3);

print "field size: $size\n";
$totalRec = 0;

$row = 1;

while ($row < $h) {
$col = 0;
  while ($col < $w) {

    my $index = $img->getPixel($col, $row);
    my ($r,$g,$b) = $img->rgb($index);
    print chr($r);
    print chr($g);
    print chr($b);

    $col++;
    if ($col % $size == 0) {
	print "\t";
       $totalRec++;
    }
  }

  $row++;
print "\n";
}
print "Possible Total Records:\t$totalRec\n";
sub usage() {
  print "pixdb_reader.pl:\n\tusage: perl pixdb_reader.pl SIZE\n\twhere SIZE = size of the fields, used in pixdb_loader.pl\n";
exit;
}
