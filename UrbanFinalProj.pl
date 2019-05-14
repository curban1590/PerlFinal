#Conner Urban
#Final Project

use strict;
#use warnings;
use Math::Round;
use Text::CSV;
use Term::Menus;
my @list=('Top Sales by Platform','Top Sales by Year','Top Sales by Genre','Top Sales by Publisher','Top Sales For Given Year','Game with the Highest Sales','Game with the Lowest Sales','Platform with the Highest Sales',
'Platform with the Lowest Sales','Publisher with the Highest Sales','Publisher with the Lowest Sales',
'Year with the Highest Sales','Year with the Lowest Sales');
my $banner="  Please Pick an Item:";
my $selection=&pick(\@list,$banner);
print "SELECTION = $selection\n";

my $csv = Text::CSV->new({ sep_char => ',' });
 
#I use a different version of the file that has been cleaned up a bit
my $file = "vgsales_fixed.csv";

my @rank;
my @name;
my @platform;
my @year;
my @genre;
my @publisher;
my @na_sales;
my @eu_sales;
my @jp_sales;
my @other_sales;
my @global_sales;


open(my $data, '<', $file) or die "Could not open '$file' $!\n";
while (my $line = <$data>) {
  chomp $line;
  if ($csv->parse($line)) {
	#each row it put in an array, then is written over when the next row is read
	my @fields = $csv->fields();
	
	#make each field an array, then push each value to the array
	push (@rank,$fields[0]);
	push (@name,$fields[1]);
	push (@platform,$fields[2]);
	push (@year,$fields[3]);
	push (@genre,$fields[4]);
	push (@publisher,$fields[5]);
	push (@na_sales,$fields[6]);
	push (@eu_sales,$fields[7]);
	push (@jp_sales,$fields[8]);
	push (@other_sales,$fields[9]); 
	push (@global_sales,$fields[10]);
	}
   else {
      warn "Line could not be parsed: $line\n";
  }
}
my $i=0;
my @platforms;
#reading all different platforms into an array
foreach my $next(@platform){
		if ($i ne 0){
			#if the platform isnt in the array of discrete platforms, add it with the sales total as the value after
			if(!(grep{$next eq $_}@platforms)){
				push(@platforms,$next);
				push(@platforms,$global_sales[$i]);
			}
			#if the platform is in the array, find it and add the sales to the total for that platform
			else{
				my $j=0;
				foreach my $nextVal (@platforms){
					if($nextVal==$next){
						$platforms[$j+1]=$platforms[$j+1]+$global_sales[$i];
					}
					$j++;
				}
			}
		}
		$i++;		
}
$i=0;
my @publishers;
#reading all different publishers into an array
foreach my $next(@publisher){
		if ($i ne 0){
			#if the publisher isnt in the array of discrete publishers, add it with the sales total as the value after
			if(!(grep{$next eq $_}@publishers)){
				push(@publishers,$next);
				push(@publishers,$global_sales[$i]);
			}
			#if the publisher is in the array, find it and add the sales to the total for that publisher
			else{
				my $j=0;
				foreach my $nextVal (@publishers){
					if($nextVal==$next){
						$publishers[$j+1]=$publishers[$j+1]+$global_sales[$i];
					}
					$j++;
				}
			}
		}
		$i++;		
}
$i=0;
my @years;
#reading all different years into an array
foreach my $next(@year){
		if ($i ne 0){
			#if the years isnt in the array of discrete years, add it with the sales total as the value after
			if(!(grep{$next eq $_}@years)){
				push(@years,$next);
				push(@years,$global_sales[$i]);
			}
			#if the years is in the array, find it and add the sales to the total for that years
			else{
				my $j=0;
				foreach my $nextVal (@years){
					if($nextVal==$next){
						$years[$j+1]=$years[$j+1]+$global_sales[$i];
					}
					$j++;
				}
			}
		}
		$i++;		
}
$i=0;
my @genres;
#reading all different genres into an array
foreach my $next(@genre){
		if ($i ne 0){
			#if the genres isnt in the array of discrete genres, add it with the sales total as the value after
			if(!(grep{$next eq $_}@genres)){
				push(@genres,$next);
				push(@genres,$global_sales[$i]);
			}
			#if the genre is in the array, find it and add the sales to the total for that genres
			else{
				my $j=0;
				foreach my $nextVal (@genres){
					if($nextVal==$next){
						$genres[$j+1]=$genres[$j+1]+$global_sales[$i];
					}
					$j++;
				}
			}
		}
		$i++;		
}

# if selection is top sales by platform
if ($selection eq 'Top Sales by Platform'){
	$i=0;
	foreach my $next(@platforms){
		if($i==0){
			print("$next  ");
			$i++;
		}
		else{
			print("$next\n");
			$i=0;
		}
	}
}
# if selection is top sales by year
if ($selection eq 'Top Sales by Year'){
	$i=0;
	foreach my $next(@years){
		if($i==0){
			print("$next  ");
			$i++;
		}
		else{
			print("$next\n");
			$i=0;
		}
	}
}
# if selection is top sales by genre
if ($selection eq 'Top Sales by Genre'){
	$i=0;
	foreach my $next(@genres){
		if($i==0){
			print("$next  ");
			$i++;
		}
		else{
			print("$next\n");
			$i=0;
		}
	}
}
# if selection is top sales by publisher
if ($selection eq 'Top Sales by Publisher'){
	$i=0;
	foreach my $next(@publishers){
		if($i==0){
			print("$next  ");
			$i++;
		}
		else{
			print("$next\n");
			$i=0;
		}
	}
}
# if selection is top sales for given year
if ($selection eq 'Top Sales For Given Year'){
	my $i=0;
	print "Please enter a Year:";
	my $input = <STDIN>;
	chomp $input;
	foreach my $next(@years){
		if($input==$next){
			print("Year: $input\nSale Amount: $years[$i+1]");
		}
		$i++;
	}
}


# if selection is game with highest sales
my $highest;
if($selection eq 'Game with the Highest Sales'){
	my $i=0;
	my $last=0;
	foreach my $next(@global_sales){
		if ($i ne 0){
			if ($next>$last){
				$highest=$i;
			}		
			$last=$next;
		}
		$i++;
	}
	print"The game with the highest global sales is $name[$highest] with $global_sales[$highest] million sales";
}
# if selection is game with lowest sales
my $lowest;
if($selection eq 'Game with the Lowest Sales'){
	my $i=0;
	my $last=0;
	foreach my $next(@global_sales){
		if ($i ne 0){
			if ($next<$last){
				$lowest=$i;
			}		
			$last=$next;
		}
		$i++;
	}
	print"\nThe game with the lowest global sales is $name[$lowest] with $global_sales[$lowest] million sales";
}
# if selection is platform with highest sales
if($selection eq 'Platform with the Highest Sales'){
	my $j=0;
	my $topPlatform=0;
	my $topPlatformSales=0;
	my $lastPlatform=0;
	my $lastSales=0;
	foreach my $next(@platforms){
		#reading platform
		if ($j==0){
			$lastPlatform=$next;	
			$j=1;
		}
		#reading sales for that platform
		else{		
			if ($next>$topPlatformSales){
				$topPlatform=$lastPlatform;
				$topPlatformSales=$next;
				$topPlatformSales=round($topPlatformSales);
			}
			$j=0;
		}
	}

	print "\nThe Platform with the highest sales is $topPlatform with $topPlatformSales million sales";
}
# if selection is platform with lowest sales
if($selection eq 'Platform with the Lowest Sales'){
	my $j=0;
	my $lastPlatform=0;
	my $lastSales=0;
	my $lowPlatform=0;
	my $lowPlatformSales=100000000;
	foreach my $next(@platforms){
		#reading platform
		if ($j==0){
			$lastPlatform=$next;	
			$j=1;
		}
		#reading sales for that platform
		else{		
			if ($next<$lowPlatformSales){
				$lowPlatform=$lastPlatform;
				$lowPlatformSales=$next;
				$lowPlatformSales=round($lowPlatformSales);
			}
			$j=0;
		}
	}
	print "\nThe Platform with the lowest sales is $lowPlatform with $lowPlatformSales million sales";
}
# if selection is publisher with highest sales
if($selection eq 'Publisher with the Highest Sales'){
	my $j=0;
	my $topPublisher=0;
	my $topPublisherSales=0;
	my $lastPublisher=0;
	foreach my $next(@publishers){
		#reading publisher
		if ($j==0){
			$lastPublisher=$next;	
			$j=1;
		}
		#reading sales for that platform
		else{		
			if ($next>$topPublisherSales){
				$topPublisher=$lastPublisher;
				$topPublisherSales=$next;
				$topPublisherSales=round($topPublisherSales);
			}
			$j=0;
		}
	}

	print "\nThe Publisher with the highest sales is $topPublisher with $topPublisherSales million sales";
}
# if selection is publisher with lowest sales
if($selection eq 'Publisher with the Lowest Sales'){
	my $j=0;
	my $lowPublisher=0;
	my $lowPublisherSales=10000000;
	my $lastPublisher=0;
	foreach my $next(@publishers){
		#reading publisher
		if ($j==0){
			$lastPublisher=$next;	
			$j=1;
		}
		#reading sales for that platform
		else{		
			if ($next<$lowPublisherSales){
				$lowPublisher=$lastPublisher;
				$lowPublisherSales=$next;
				#$lowPublisherSales=round($lowPublisherSales); rounding makes this number too small to use
			}
			$j=0;
		}
	}

	print "\nThe Publisher with the lowest sales is $lowPublisher with $lowPublisherSales million sales";
}
# if selection is year with highest sales
if($selection eq 'Year with the Highest Sales'){
	my $j=0;
	my $topYear=0;
	my $topYearSales=0;
	my $lastYear=0;
	foreach my $next(@years){
		#reading publisher
		if ($j==0){
			$lastYear=$next;	
			$j=1;
		}
		#reading sales for that platform
		else{		
			if ($next>$topYearSales){
				$topYear=$lastYear;
				$topYearSales=$next;
				$topYearSales=round($topYearSales);
			}
			$j=0;
		}
	}

	print "\nThe Year with the highest sales is $topYear with $topYearSales million sales";
}
# if selection is year with lowest sales
if($selection eq 'Year with the Lowest Sales'){
	my $j=0;
	my $lowYear=0;
	my $lowYearSales=100000000000000000;
	my $lastYear=0;
	foreach my $next(@years){
		#reading publisher
		if ($j==0){
			$lastYear=$next;	
			$j=1;
		}
		#reading sales for that platform
		else{		
			if ($next<$lowYearSales){
				$lowYear=$lastYear;
				$lowYearSales=$next;
				#$lowYearSales=round($lowYearSales);
			}
			$j=0;
		}
	}

	print "\nThe Year with the lowest sales is $lowYear with $lowYearSales million sales";
}
