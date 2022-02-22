# Aman Pankaj Adatia
# 2020CSB1154

use strict;
# use warnings;

# VARIABLES
# This array contains list of words.
my @sampleWords = ("computer", "radio", "calculator", "teacher", "bureau", "police", "geometry", "president", "subject", "country", "enviroment", "classroom", "animals", "province", "month", "politics", "puzzle", "instrument", "kitchen", "language", "vampire", "ghost", "solution", "service", "software", "virus", "security", "phonenumber", "expert", "website", "agreement", "support", "compatibility", "advanced", "search", "triathlon", "immediately", "encyclopedia", "endurance", "distance", "nature", "history", "organization", "international", "championship", "government", "popularity", "thousand", "feature", "wetsuit", "fitness", "legendary", "variation", "equal", "approximately", "segment", "priority", "physics", "branche", "science", "mathematics", "lightning", "dispersion", "accelerator", "detector", "terminology", "design", "operation", "foundation", "application", "prediction", "reference", "measurement", "concept", "perspective", "overview", "position", "airplane", "symmetry", "dimension", "toxic", "algebra", "illustration", "classic", "verification", "citation", "unusual", "resource", "analysis", "license", "comedy", "screenplay", "production", "release", "emphasis", "director", "trademark", "vehicle", "aircraft", "experiment");

my $totalWords = @sampleWords;  # total number of words
my $ranNum = int(rand($totalWords));  # choosing random number - position in word array
my $ranWord = $sampleWords[$ranNum];  # word at the random position chosen
my $ranWordSize = length $ranWord;  # length of the random rowrd chosen
my $wrongGuess = 0;  # variable to keep track of wrong guesses
my @curWord = ('_')x$ranWordSize;  # array where the correct guessed word will be stored
my @alreadyGuessed = ();  # array to keep track alphabets already guesses
my $gameOver = 0; 

# print "$ranWord \n";

# Game Start
print "Welcome to HANGMAN \n";
print "Guess the word or die! \n";

while($gameOver == 0){
    # display hangman based on wrong guesses at the time of calling
    displayHangman($wrongGuess);

    print "Word:  @curWord \n"; # current state of the word to be guessed
    print "Alphabets guessed so far:  @alreadyGuessed \n"; # alphabets already guesses up till now
    print "Enter guess: ";
    my $guess = <STDIN>; # taking input
    chomp($guess);

    # checking if the input by user is valid or not
    my $checkValid = validate($guess);
    if($checkValid == 0){ 
        print "Invalid Inupt!\n";
        next; # skip rest of the program in this case
    }

    # check if already guessed
    my $checkGuessed = 0;
    for(my $i=0; $i<@alreadyGuessed; $i++){
        if ($alreadyGuessed[$i] eq $guess){
            $checkGuessed = 1;
            # last; # break out of for loop
        }
    }
    if($checkGuessed == 1){
        print "You have already guessed this letter. \n";
        next; # skip further program and ask guess again
    }

    push(@alreadyGuessed, $guess);
    # checking if guess is present
    my $checkPresent = check($guess, $ranWord, \@curWord);
    if($checkPresent == 1){
        print "Your guess was correct! \n";
    }
    else{ 
        print "Your guess was incorrect! \n";
        $wrongGuess++; # if not present in the word 
    }

    # losing condition
    if($wrongGuess == 6){ 
        displayHangman($wrongGuess);
        print "You lost the game! \n";
        print "The word was: $ranWord \n"; # displaying the corrrect word
        $gameOver = 1;
        last; # break 
    }
    
    # winning condition
    if(isGameWon(@curWord) == 1){ 
        print "@curWord \n";
        print "Congrats, you have won the game! \n";
        $gameOver = 1;
        last; # break
    }

    print "\n";
}

# checks if the guessed alphabet is present in given word (ranWord) or not. if it is present then it updates the curWord.
sub check{
    my ($guess, $ranWord, $wordRef) = @_;
    my $isPresent = 0;
    for (my $i=0; $i<length($ranWord); $i++){
        if (substr($ranWord,$i, 1) eq $guess){
            $$wordRef[$i] = $guess;
            $isPresent = 1;
        }
    }
    return $isPresent;
}

# checks if the player has won the game or not
sub isGameWon{
    (my @curWord) = @_;
    my $won = 1;
    for(my $i=0; $i<$ranWordSize; $i++){
        if($curWord[$i] eq '_'){
            $won = 0;
        }
    }
    return $won;
}

# checks if the input guess is valid (i.e. should only be a lower case english alphabet)
sub validate{
    my ($guess) = @_;
    my $isValid = 1;
    if($guess =~ /^[a-z]+$/){
        $isValid = 1;
    }
    else{
        $isValid = 0;
    }
    if(length($guess) != 1){
        $isValid = 0;
    }
    return $isValid;
}

# displays hangman based on number of wrong guesses when called.
sub displayHangman{
    (my $wrongGuess) = @_;
    if($wrongGuess == 0){
        print " +---+ \n";
        print " |   | \n";
        print " | \n";
        print " | \n";
        print " | \n";
        print " | \n";
        print "=======\n";
    }
    if($wrongGuess == 1){
        print " +---+ \n";
        print " |   | \n";
        print " |   O \n";
        print " | \n";
        print " | \n";
        print " | \n";
        print "=======\n";
    }
    if($wrongGuess == 2){
        print " +---+ \n";
        print " |   | \n";
        print " |   O \n";
        print " |   | \n";
        print " | \n";
        print " | \n";
        print "=======\n";
    }
    if($wrongGuess == 3){
        print " +---+ \n";
        print " |   | \n";
        print " |   O \n";
        print " |  /| \n";
        print " | \n";
        print " | \n";
        print "=======\n";
    }
    if($wrongGuess == 4){
        print " +---+ \n";
        print " |   | \n";
        print " |   O \n";
        print " |  /|\\ \n";
        print " | \n";
        print " | \n";
        print "=======\n";
    }
    if($wrongGuess == 5){
        print " +---+ \n";
        print " |   | \n";
        print " |   O \n";
        print " |  /|\\ \n";
        print " |  /  \n";
        print " | \n";
        print "=======\n";
    }
    if($wrongGuess == 6){
        print " +---+ \n";
        print " |   | \n";
        print " |   O \n";
        print " |  /|\\ \n";
        print " |  / \\ \n";
        print " | \n";
        print "=======\n";
    }
}

