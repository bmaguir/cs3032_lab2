 use Thread;
 use IO::Socket;
 {
	$socket = IO::Socket::INET->new(
		LocalHost => 'localhost',
		LocalPort => '2000',
		Proto => 'tcp',
		Listen => 1,
		Reuse => 1
	)
	or die "Coudn't open socket$!" unless $socket;
	print "socket listening on port 2000\n";
	my @thr;

	while(true){
		my $new_sock = $socket->accept();
		#adds a new thread to the pool to handle the client 
		push(@thr, new Thread \&sub1, $new_sock);
	}


	sub sub1 { 
		$msg;
		my $thread_socket = $_[0];
		while(<$thread_socket>) {
			$msg = $_;
		}
		if($msg eq "KILL_SERVICE\n"){
			print $msg;
			exit &end;
		}
		else{
			print "client said $msg";
		}
	}

	sub end {
		print "closing socket\n";
		close($socket);
		#close socket and clean up all used threads
		@thr = my @thr;
		foreach(@thr){
		$_->join;
		}
	}
}