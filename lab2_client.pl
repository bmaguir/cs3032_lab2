use IO::Socket;

my $socket = IO::Socket::INET->new(
    PeerAddr =>'localhost',
	PeerPort => '2000',
    Proto => 'tcp'
) or die("Error :: $!");

print "please enter the message you wish to send \n";
#takes a line from the keyboard 
my $msg=<STDIN>;

print ($socket $msg);



close $socket;