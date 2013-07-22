public import celler;
import agregator, changer;

class Automata : Celler {
    private int[][2] _cells;
    private size_t _x, _y, _h = 0;

    this(size_t x, size_t y) {
        _cells = new int[][2];
        _x = x;
        _y = y;

        foreach (ref half; _cells) {
            half.length = _y * _x;
        }
    }

    override void fill(Agregator agr) {
        for (size_t iy = 0; iy < _y; iy++) {
            for (size_t ix = 0; ix < _x; ix++) {
                _cells[_h][i(ix, iy)] = agr.initValue(ix, iy);
            }
        }
    }

    override size_t x() const { return _x; }
    override size_t y() const { return _y; }

    override int state(size_t x, size_t y) const {
        return _cells[_h][i(x, y)];
    }

    override void next(Changer changer) {
        size_t next = (_h == 0) ? 1 : 0;
        for (size_t iy = 0; iy < _y; iy++) {
            for (size_t ix = 0; ix < _x; ix++) {
                _cells[next][i(ix, iy)] = changer.next(this, ix, iy);
            }
        }
        _h = next;
    }

    const(int)[] slice() {
        return _cells[_h];
    }

    void invert(size_t x, size_t y) {
        _cells[_h][i(x, y)] = (_cells[_h][i(x, y)] == 0) ? 1 : 0;
    }

    private size_t i(size_t x, size_t y) const {
        return _x * y + x;
    }
}

unittest {
    auto a = new Automata(10, 5);
    assert(a.x() == 10);
    assert(a.y() == 5);

    int defaultState = 555;
    class TestAgregator : Agregator {
        override int initValue(size_t x, size_t y) const {
            return defaultState;
        }
    }

    a.fill(new TestAgregator);
    assert(a.state(0, 0) == defaultState);
    assert(a.state(2, 2) == defaultState);

    auto zag = new ZeroAgregator;

    class TestChanger : Changer {
        override int value(int current, in uint[int] _) const {
            return (current == 0) ? 1 : 0;
        }
    }

    a.fill(zag);
    auto tchanger = new TestChanger;
    a.next(tchanger);
    assert(a.state(0, 0) == 1);
    assert(a.state(2, 2) == 1);

    a.next(tchanger);
    assert(a.state(0, 0) == 0);
    assert(a.state(2, 2) == 0);

    a.fill(zag);
    auto lfchanger = new LifeChanger;
    a.invert(0, 1);
    a.invert(0, 0);
    a.invert(0, 4);

    a.next(lfchanger);
    // TODO: debug it
    assert(a.state(0, 1) == 0);
    assert(a.state(0, 0) == 1);
    assert(a.state(0, 4) == 0);
    assert(a.state(1, 0) == 1);
    assert(a.state(9, 0) == 1);

    a.next(lfchanger);
    assert(a.state(0, 1) == 1);
    assert(a.state(0, 0) == 1);
    assert(a.state(0, 4) == 1);
    assert(a.state(1, 0) == 0);
    assert(a.state(9, 0) == 0);
}
