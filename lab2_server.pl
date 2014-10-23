 use Thread;
 use IO::Socket;

 {
	my $port = $ARGV[0];
	$socket = IO::Socket::INET->new(
		LocalPort => $port,
		Proto => 'tcp',
		Listen => 5,
		Reuse => 1
	)
	or die "Coudn't open socket$!" unless $socket;
	print "socket listening on port $port\n";
	my @thr;

	while(true){
		my $new_sock = $socket->accept();
		#adds a new thread to the pool to handle the client 
		print "got me a new coonektionzz\n";
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
		print "in new thread\n";
		$thread_socket-> recv($msg, 50, 0);
		#while(<$thread_socket>) {
		#	$msg = $_;
		#	print "$_\n";
		#}
		print "read new message\n";
		if($msg eq "KILL_SERVICE\n"){
			print $msg;
			close(thread_socket);
			exit &end;
		}
		else{
			if(substr($msg,0,4) eq "HELO")
			{
				my $address = "macneill.scss.tcd.ie";#$thread_socket->sockhost;
				$last_char = substr($msg,$msg.length-1, $msg.length);
				print "last char :{$last_char}:";
				print($thread_socket "${msg}IP:macneill.scss.tcd.ie\nPort:${port}\nStudentID:10366921");
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
		foreach(@thr){
		if($_->is_joinable())
			{
			$_->detach();
			}
		}
	}
}