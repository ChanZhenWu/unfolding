print "\n";
print "*******************************************************************************\n";
print "  unfold devices items <v1.0>\n";
print "  Author: Noon Chen\n";
print "  A Professional Tool for Test.\n";
print "  ",scalar localtime;
print "\n*****************************************************************************\n";
print "\n";

use strict;
use warnings;

print "  please specify source file here: ";
   my $source=<STDIN>;
   chomp $source;

print $source;

############################### source file process ######################################

print  "\n  >>> unfolding ... \n";

open (Export, "> new_$source"); 
open (Import, "< $source"); 
	while(my $array = <Import>)
	{
		chomp $array;
		$array =~ s/\s+//g;	   #clear head of line spacing
		if ($array =~ "\-")
			{
		my @fields = split(/-/, $array);
			print " * ".$array."\n";
			#print scalar@fields."\n";
			#print $fields[0]."\n";  # 1st field
			#print $fields[1]."\n";  # 2nd field

		my $string = "";
		my $suffix = "";
		my $style = "CDCD";  # C for character, D for digit
		my @Comp = split(/([a-z]+)/i, $fields[0]);
			#print scalar@Comp."\n";
			my $begin = $Comp[scalar@Comp - 1];  # begin
			if ($begin =~ /([a-z]+)/i)
				{$begin = $Comp[scalar@Comp - 2]; $suffix = $Comp[scalar@Comp - 1]; $style = "CDC";}  # begin
			#print $begin."\n";

			@Comp = split(/([a-z]+)/i, $fields[1]);
			#print scalar@Comp."\n";
			my $final = $Comp[scalar@Comp - 1];  # final
			if ($final =~ /([a-z]+)/i)
				{$final = $Comp[scalar@Comp - 2]; $suffix = $Comp[scalar@Comp - 1]; $style = "CDC";}  # final
			#print $final."\n";

			if ($style eq "CDCD")
			{
			#print "CDCD\n";
			for (my $num = $begin; $num < $final+1; $num++)
				{
					$string = substr($fields[0],0,length($fields[0])-length($begin)).$num;
					if(length($fields[0]) - length($string) == 1){$string = substr($fields[0],0,length($fields[0])-length($begin))."0".$num;}
					if(length($fields[0]) - length($string) == 2){$string = substr($fields[0],0,length($fields[0])-length($begin))."00".$num;}
					if(length($fields[0]) - length($string) == 3){$string = substr($fields[0],0,length($fields[0])-length($begin))."000".$num;}
					if(length($fields[0]) - length($string) == 4){$string = substr($fields[0],0,length($fields[0])-length($begin))."0000".$num;}
					
					printf Export $string."\n";
					print $string."\n";
				}
			}

			if ($style eq "CDC")
			{
			#print "CDC\n";
			for (my $num = $begin; $num < $final+1; $num++)
				{
					$string = substr($fields[0],0,index($fields[0],$begin)).$num.$suffix;
					if(length($fields[0]) - length($string) == 1){$string = substr($fields[0],0,index($fields[0],$begin))."0".$num.$suffix;}
					if(length($fields[0]) - length($string) == 2){$string = substr($fields[0],0,index($fields[0],$begin))."00".$num.$suffix;}
					if(length($fields[0]) - length($string) == 3){$string = substr($fields[0],0,index($fields[0],$begin))."000".$num.$suffix;}
					if(length($fields[0]) - length($string) == 4){$string = substr($fields[0],0,index($fields[0],$begin))."0000".$num.$suffix;}
					
					printf Export $string."\n";
					print $string."\n";
				}
			}
			
			}
		else
			{
				print $array,"\n";
				print Export $array,"\n";
			}
		}
close Import;

print "  >>>done ...\n";


########################################################@#################################


