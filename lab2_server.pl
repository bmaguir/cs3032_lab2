 use Thread;
 use IO::Socket;
 {
 
	my $port = '2000';
	$socket = IO::Socket::INET->new(
		LocalHost => 'localhost',
		LocalPort => $port,
		Proto => 'tcp',
		Listen => 1,
		Reuse => 1
	)
	or die "Coudn't open socket$!" unless $socket;
	print "socket listening on port $port\n";
	my @thr;

	while(true){
		my $new_sock = $socket->accept();
		#adds a new thread to the pool to handle the client 
		$thread_count = threads->list();
		#if the thread pool has not been used, start new thread
		if(thread_count < 5){
			push(@thr, new Thread \&sub1, $new_sock);
		}
		foreach(@thr){
			if ($_->is_joinable()) {
				$_->join();
			}
		}
	}


	sub sub1 { 
		$msg;
		my $thread_socket = $_[0];
		while(<$thread_socket>) {
			$msg = $_;
		}
		if($msg eq "KILL_SERVICE\n"){
			print $msg;
			close(thread_socket);
			exit &end;
		}
		else{
			if($msg eq "HELO text\n")
			{
				print "client said $msg";
				print($thread_socket "HELO text\nIP:[ip address]\nPort: $port\nStudentID: 10366921");
				close($thread_socket);
			}
			else
			{
				print "client said $msg";
				print($thread_socket "ack");
				close($thread_socket);
			}
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