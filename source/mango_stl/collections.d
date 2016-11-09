module mango_stl.collections;

import mango_stl.exception;

import std.exception;
import std.algorithm;
import std.conv;

class ArrayList(T) {
	__gshared {
		protected T[] values;
	}
	
	void add(T val) @trusted {
		synchronized(this) {
			values ~= val;
		}
	}
	
	void remove(size_t location) @trusted {
		synchronized(this) {
			this.values = remove(values, location);
		}
	}
	
	void clear() @trusted {
		synchronized(this) {
			values.length = 0;
		}
	}
	
	void debugDump() {
		import std.stdio;
		writeln("Dump: ", values);
	}
}

class Queue(T) {
    __gshared {
        protected size_t valueCounter = 0;
        protected T[size_t] values;
        
        protected size_t head = 0;
    }

    void add(T val) @trusted {
        synchronized(this) {
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
            auto val = values[head];
			values.remove(head);
            head = head + 1;
            return val;
        }
    }
    
    bool isEmpty() {
    	return values.length <= 0;
    }
	
	void debugDump() {
		import std.stdio;
		writeln("Head: ", head, ", ", valueCounter, ", Values: ", values);
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
		values.remove(head);
        head = head + 1;
        return val;
    }
    
    bool isEmpty() @trusted nothrow {
    	return values.length <= 0;
    }
}
