use GD;
$totalCols = 125;
$h = 1400;
$size = 9;
$w = $size * $totalCols;

$img = new GD::Image($w, $h,1);

$white = $img->colorAllocate(255,255,255);
    $black = $img->colorAllocate(0,0,0);       
    $red = $img->colorAllocate(255,0,0);      
    $blue = $img->colorAllocate(0,0,255);
if (!$ARGV[0]) {
  usage();
}
        
my $count;        
$img->colorAllocate(255,255,255);
$img->transparent($white);
$img->interlaced('true');
open(IN,"<$ARGV[0]");
@colors;
my $header = $img->colorAllocate($totalCols, $size,$h);
    $img->setPixel(0,0,$header); 
$row = 1;
$flag = 0;  
while(<IN>) {
  print $_;
  chomp;

  next if length($_) > $size;

  $col = 0 + ($flag * $size);

  foreach my $l (split(/|/,$_)) {
    $o = ord($l);
    @rgb = (0,0,0);
    $rgb[int($col %3)] = $o;
    print "( @rgb ) @ $col:$row\n";


    #my $color = $img->colorAllocate(ord($l),0,0);
    #$color["$col,$row"] = $img->colorAllocate($rgb[0], $rgb[1],$rgb[2]);
    $color["$col,$row"] = $img->colorAllocate($o,$o,$o);
    $img->setPixel($col,$row,$color["$col,$row"]); 
    $col++
  } 
  $count++;
  $row++;
  if ($row == $h) {
    last if $col >= $w;
    $flag++;
    $row = 0;
  }
}
open(OUT,"> testpng.gif");
binmode OUT;
print OUT $img->gif;
close(OUT);
open(OUT,"> testpng.png");
binmode OUT;
print OUT $img->png;
close(OUT);
open(OUT,"> testpng.jpg");
binmode OUT;
print OUT $img->jpeg;

print "Total Records: $count\n";

sub usage() {

  print "pixdb_loader.pl\n
\tusage: perl pixdb_loader.pl wordlistfile\n
\tworldlist file is a list of words delimited by cr/lf\n";
exit;         

}
