import std.random;

interface Agregator {
    int initValue(size_t x, size_t y) const;
}

class RandomAgregator : Agregator {
    override int initValue(size_t x, size_t y) const {
        return uniform(0, 2);
    }
}

class ZeroAgregator : Agregator {
    override int initValue(size_t x, size_t y) const {
        return 0;
    }
}