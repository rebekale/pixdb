use GD;
$w = 90;
$h = 300;
$img = new GD::Image->newFromPng('testpng.png',1);

$row = 0;

while ($row < $h) {
$col = 0;
  while ($col < $w) {

    my $index = $img->getPixel($col, $row);
    my ($r,$g,$b) = $img->rgb($index);
    print chr($r);

    $col++;
    if ($col % 9 == 0) {
	print "\t";
    }
  }

  $row++;
print "\n";
}
