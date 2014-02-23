use GD;

$img = new GD::Image->newFromPng('testpng.png',1);
$img->interlaced('true');
my ($w,$h) = $img->getBounds();

if (!$ARGV[0]) {
  #usage();
}
my $header = $img->getPixel(0,0);
my ($totalCols,$size,$maxRows) = $img->rgb($header);
$size = chr($size);

print "field size: $size\n";


$row = 1;

while ($row < $h) {
$col = 0;
  while ($col < $w) {

    my $index = $img->getPixel($col, $row);
    my ($r,$g,$b) = $img->rgb($index);
    print chr($r);

    $col++;
    if ($col % $size == 0) {
	print "\t";
    }
  }

  $row++;
print "\n";
}

sub usage() {
  print "pixdb_reader.pl:\n\tusage: perl pixdb_reader.pl SIZE\n\twhere SIZE = size of the fields, used in pixdb_loader.pl\n";
exit;
}
