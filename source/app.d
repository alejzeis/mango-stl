import std.stdio;
import std.datetime;

import mango_stl.collections;

void main() {
	Queue!string list = new Queue!string();
	string st = "testing 123123123sadfasdf";

	list.add(st);
	list.add("123123");
	list.add("hffwere");
	list.add("asdfasdjflk;wqenr;kqwern");

	StopWatch sw = StopWatch();
	sw.start();
	string s = list.pop();
	sw.stop();

	writeln(s);

	writeln(sw.peek.nsecs);
}
