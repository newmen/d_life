import std.random;

interface Agregator {
    int initValue();
}

class RandomAgregator : Agregator {
    override int initValue() {
        return uniform(0, 2);
    }
}

