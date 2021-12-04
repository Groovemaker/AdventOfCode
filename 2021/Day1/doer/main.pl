### Sonar Incrementor
### (c) 2021 - Runic
### Purpose: Counting how much the Sonar depth increments. | https://adventofcode.com/

### Main

## Using CPAN, because i am not an idiot.
use File::Slurp;

## Open and Read File.
my $filename = "./input.txt";
my $Content = read_file($filename);

## Str to Array.
my @Arr = split('\n', $Content);

my $Increment_Count = 0;

## Hammer Time.
for my $i (0 .. $#Arr) {

    # Init vars.
    my $IsIncrement;

    # Declare Num and NextNum.
    my $Num = $Arr[$i];
    my $NextNum = $Arr[$i+1];

    # If the current number is smaller than the Next one, it is incremented in the next one.
    $IsIncrement = $Num < $NextNum;
    if($IsIncrement){

        # Register increment.
        print "$Num to ";
        print "$NextNum - INCREMENT\n";
        $Increment_Count++

    }else{

        # No increment? Just print the number.
        print "$Num to $NextNum\n";

    }

}

## It is done, print filename and increment counts. The increment count is submitted as the answer on the website.
print "\nFile [$filename] - File runthrough increments: -> $Increment_Count <- Submit this on the website.\n";
