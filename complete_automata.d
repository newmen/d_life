import automata, agregator, changer;

AutomataInterface globalAutomata;

extern(C++) {
    interface AutomataInterface {
        void next();

        void save();
        void restore();
        void zerofile();

        void invert(size_t x, size_t y);

        int state(size_t x, size_t y) const;

        size_t x() const;
        size_t y() const;
    }

    AutomataInterface createAutomata(uint x, uint y) {
        if (!globalAutomata) globalAutomata = new CompleteAutomata(x, y);
        return globalAutomata;
    }
}

export class CompleteAutomata : AutomataInterface {
    Automata automata;
    const(int)[] slice;

    this(size_t x, size_t y) {
        automata = new Automata(x, y);
        automata.fill(new RandomAgregator);
    }

    extern(C++) {
        override void next() {
            static Changer changer;
            if (!changer) changer = new LifeChanger;
            automata.next(changer);
        }

        override void save() {
            slice = automata.slice().dup;
        }

        override void restore() {
            class SliceAgregator : Agregator {
                override int initValue(size_t x, size_t y) const {
                    return slice[automata.x() * y + x];
                }
            }

            static Agregator agregator;
            if (!agregator) agregator = new SliceAgregator;
            automata.fill(agregator);
        }

        override void zerofile() {
            static Agregator agregator;
            if (!agregator) agregator = new ZeroAgregator;
            automata.fill(agregator);
        }

        override void invert(size_t x, size_t y) {
            automata.invert(x, y);
        }

        override int state(size_t x, size_t y) const {
            return automata.state(x, y);
        }

        override size_t x() const { return automata.x(); }
        override size_t y() const { return automata.y(); }
    }
}

unittest {
    CompleteAutomata ca = new CompleteAutomata(8, 5);
    assert(ca.x() == 8);
    assert(ca.y() == 5);

    int a = ca.state(0, 0),
        b = ca.state(2, 2),
        c = ca.state(4, 4);
    ca.save();

    ca.zerofile();
    assert(ca.state(0, 0) == 0);
    assert(ca.state(2, 2) == 0);

    ca.restore();
    assert(a == ca.state(0, 0));
    assert(b == ca.state(2, 2));
    assert(c == ca.state(4, 4));
}
