module mango_stl.exception;

class InvalidArgumentException : Exception {
    
    this(in string message) @safe nothrow {
        super(message);
    }
}