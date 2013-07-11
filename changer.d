import celler;

interface Changer {
    int value(int current, in uint[int] acc) const;

    final int next(Celler celler, size_t x, size_t y) const {
        uint[int] acc;
        acc[1] = 0;
        for (int iy = -1; iy < 2; iy++) {
            for (int ix = -1; ix < 2; ix++) {
                if (iy == ix) continue;

                size_t rix = correct(x + iy, celler.x());
                size_t riy = correct(y + ix, celler.y());
                ++acc[celler.state(rix, riy)];
            }
        }

        return value(celler.state(x, y), acc);
    }

    final private size_t correct(size_t index, size_t limit) const {
        if (index < 0) index = limit - 1;
        else if (index >= limit) index = 0;
        return index;
    }
}

class LifeChanger : Changer {
    override int value(int current, in uint[int] acc) const {
        if (acc[1] == 3) return 1;
        else if (current == 1 && acc[1] == 2) return 1;
        else return 0;
    }
}

unittest {
    auto changer = new LifeChanger;
    uint[int] acc;

    acc[1] = 3;
    assert(changer.value(0, acc) == 1);
    assert(changer.value(1, acc) == 1);

    acc[1] = 2;
    assert(changer.value(1, acc) == 1);

    void checkFor(int v, int w) {
        foreach (i; 0 .. 9) {
            assert(changer.value(v, acc) == w);
        }
    }

    void checkRange(int v, int w, int min, int max) {
        foreach (i; min .. (max + 1)) {
            acc[1] = i;
            checkFor(v, w);
        }
    }

    checkRange(0, 0, 0, 2);
    checkRange(0, 0, 4, 8);
    checkRange(1, 0, 0, 1);
    checkRange(1, 0, 4, 8);
}