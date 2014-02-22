use GD;
$w = 180;
$h = 400;

$img = new GD::Image($w, $h,1);

$white = $img->colorAllocate(255,255,255);
    $black = $img->colorAllocate(0,0,0);       
    $red = $img->colorAllocate(255,0,0);      
    $blue = $img->colorAllocate(0,0,255);
if (!$ARGV[0]) {
  usage();
}
        
        
$img->colorAllocate(255,255,255);
$img->transparent($white);
$img->interlaced('true');
open(IN,"<$ARGV[0]");
@colors;
$row = 0;
$flag = 0;  
while(<IN>) {
print $_;
  chomp;
next if length($_) > 9;
  $col = 0 + ($flag * 9);
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

sub usage() {

  print "pixdb_loader.pl\n
\tusage: perl pixdb_loader.pl wordlistfile\n
\tworldlist file is a list of words delimited by cr/lf\n";
exit;         

}
