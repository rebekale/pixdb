if (!$ARGV[3] ) {
  usage();
}
use GD;
$totalCols = $ARGV[2];
$h = $ARGV[1];
$size = $ARGV[0];
$w = $size * $totalCols;

$img = new GD::Image($w, $h,1);
$img = new GD::Image($w, $h,1);

$white = $img->colorAllocate(255,255,255);
    $black = $img->colorAllocate(0,0,0);       
    $red = $img->colorAllocate(255,0,0);      
    $blue = $img->colorAllocate(0,0,255);
        
my $count;        
$img->colorAllocate(255,255,255);
$img->transparent($white);
$img->interlaced('true');
open(IN,"<$ARGV[3]");
$color;

print "t\t $totalCols:".ord($totalCols).", s\t $size:".ord($size).", h\t $h:".ord($h)."\n";
my $header = $img->colorAllocate(ord($totalCols), ord($size),ord($h));
    $img->setPixel(0,0,$header); 

$row = 1;
$flag = 0;  
while(<IN>) {
  #print $_;
  chomp;

  next if length($_) > $size;

  $col = 0 + ($flag * $size);

  foreach my $l (split(/|/,$_)) {
    $o = ord($l);
    @rgb = (0,0,0);
    $rgb[int($col %3)] = $o;
    #print "( @rgb ) @ $col:$row\n";


    #my $color = $img->colorAllocate(ord($l),0,0);
    #$color["$col,$row"] = $img->colorAllocate($rgb[0], $rgb[1],$rgb[2]);
    $color->{"$col,$row"} = $img->colorAllocate($o,$o,$o);
    $img->setPixel($col,$row,$color->{"$col,$row"}); 
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
\tusage: perl pixdb_loader.pl fieldsize maxrows maxcolumns wordlistfile\n
\tworldlist file is a list of words delimited by cr/lf\n";
print"\texample: perl pixdb_loader.pl 6 1000 10 wordlist.txt \n\t creates a file with 1000 rows and 10 columns of 6 character records\n";
exit;         

}
