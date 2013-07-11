public import celler;
import agregator, changer;

class Automata : Celler {
    private auto _cells = new int[][2];
    private size_t _x, _y, _h = 0;

    this(size_t x, size_t y) {
        _x = x;
        _y = y;

        foreach (ref half; _cells) {
            half.length = _y * _x;
        }
    }

    override void fill(Agregator agr) {
        foreach (ref state; _cells[_h]) {
            state = agr.initValue();
        }
    }

    override size_t x() const { return _x; }
    override size_t y() const { return _y; }

    override int state(size_t x, size_t y) const {
        return _cells[_h][y * _x + x];
    }

    override void next(Changer changer) {
        size_t next = (_h == 0) ? 1 : 0;
        for (size_t iy = 0; iy < _y; iy++) {
            for (size_t ix = 0; ix < _x; ix++) {
                _cells[next][iy * _x + ix] = changer.next(this, ix, iy);
            }
        }
        _h = next;
    }
}

unittest {
    auto a = new Automata(10, 5);
    assert(a.x() == 10);
    assert(a.y() == 5);

    int defaultState = 0;
    class TestAgregator : Agregator {
        override int initValue() {
            return defaultState;
        }
    }

    a.fill(new TestAgregator);
    assert(a.state(0, 0) == defaultState);
    assert(a.state(2, 2) == defaultState);

    class TestChanger : Changer {
        override int value(int current, in uint[int] _) const {
            return (current == 0) ? 1 : 0;
        }
    }

    auto changer = new TestChanger;
    a.next(changer);
    assert(a.state(0, 0) == 1);
    assert(a.state(2, 2) == 1);
    a.next(changer);
    assert(a.state(0, 0) == 0);
    assert(a.state(2, 2) == 0);
}
