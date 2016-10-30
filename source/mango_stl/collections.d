module mango_stl.collections;

import mango_stl.exception;

import std.exception;
import std.conv;

class Queue(T) {
    __gshared {
        protected size_t counter = 0;
        protected T[size_t] pointers;
    }

    void add(T val) @trusted {
        synchronized(this) {
            pointers[counter++] = val;
        }
    }

    void remove(size_t id) @trusted {
        synchronized(this) {
            pointers.remove(id);
        }
    }

    void clear() @trusted {
        synchronized(this) {
            counter = 0;
            pointers.clear();
        }
    }

    T pop() @trusted {
        synchronized(this) {
            auto v = pointers[0];
            remove(0);
            return v;
        }
    }
}