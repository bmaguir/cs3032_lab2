use IO::Socket;

while(true){

	print "please enter the message you wish to send \n";
	#takes a line from the keyboard 
	$msg=<STDIN>;
	if($msg eq "end\n"){
		exit(0);
	}
	
	my $socket = IO::Socket::INET->new(
		PeerAddr =>'macneill.scss.tcd.ie',
		PeerPort => '1962',
		Proto => 'tcp'
	) or die("Error :: $!");

	print ($socket $msg);
	shutdown($socket, 1);
	my $recv_line;
	#prints out what is received from the server
	while ($recv_line = <$socket>){
		print "$recv_line\n";
	}

	close $socket;
}