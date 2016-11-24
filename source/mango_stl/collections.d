module mango_stl.collections;

import mango_stl.exception;

import std.exception;
import std.algorithm;
import std.conv;

private alias algorithm_remove = std.algorithm.remove;

class ArrayList(T) {
	shared {
		protected T[] values;
	}
	
	void reserve(size_t amount) @trusted {
	    synchronized(this) {
	        values.reserve(amount);
	    }
	}
	
	void add(T val) @trusted {
		synchronized(this) {
			values ~= val;
		}
	}
	
	void remove(size_t location) @trusted {
		synchronized(this) {
			this.values = algorithm_remove(values, location);
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
    shared {
        protected size_t valueCounter = 0;
        protected T[size_t] values;
        
        protected size_t head = 0;
    }

    void add(T val) @trusted {
        import core.atomic : atomicOp;
        synchronized(this) {
            values[atomicOp!"+="(this.valueCounter, 1)] = val;
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
        synchronized(this) {
            enforce(!isEmpty(), new Exception("Queue is empty!"));

            auto val = values[head];
            values.remove(head);
            head = head + 1;
            return val;
        }
    }
    
    bool isEmpty() {
	    synchronized(this) {
    	    return values.length <= 0;
        }
    }
	
	void debugDump() {
		import std.stdio;
		writeln("Head: ", head, ", ", valueCounter, ", Values: ", values);
	}
}

class UnsafeQueue(T) {
    shared {
        protected size_t valueCounter = 0;
        protected T[size_t] values;
        
        protected size_t head = 0;
    }

    void add(T val) @trusted nothrow {
        import core.atomic : atomicOp;
        values[atomicOp!"+="(this.valueCounter, 1)] = val;
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
