module mango_stl.collections;

import mango_stl.exception;

import std.exception;
import std.conv;

class Queue(T) {
    __gshared {
        protected size_t valueCounter = 0;
        protected T[size_t] values;
        
        protected size_t head = 0;
    }

    void add(T val) @trusted {
		import std.stdio;
		writeln("Adding Queue");
        synchronized(this) {
			debug {
				import std.stdio;
				writeln("Adding Head: ", head, ", valueCounter ", valueCounter, " values ", values);
			}
            values[valueCounter++] = val;
        }
    }

    void clear() @trusted {
        synchronized(this) {
            head = 0;
            valueCounter = 0;
            values.clear();
        }
    }

    T pop() @trusted {
    	enforce(!isEmpty(), new Exception("Queue is empty!"));
        synchronized(this) {
			debug {
				import std.stdio;
				writeln("Length: ", values.length, "Head: ", head, ", valueCounter ", valueCounter, " values ", values);
			}
            auto val = values[head];
			values.remove(head);
            head = head + 1;
            return val;
        }
    }
    
    bool isEmpty() {
    	return values.length < 0;
    }
}

class UnsafeQueue(T) {
    __gshared {
        protected size_t valueCounter = 0;
        protected T[size_t] values;
        
        protected size_t head = 0;
    }

    void add(T val) @trusted nothrow {
        values[valueCounter++] = val;
    }

    void clear() @trusted nothrow {
        head = 0;
        valueCounter = 0;
        values.clear();
    }

    T pop() @trusted nothrow {
        auto val = values[head];
        head = head + 1;
        return val;
    }
    
    bool isEmpty() @trusted nothrow {
    	return values.length < 0;
    }
}
