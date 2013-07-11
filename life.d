import std.conv : to;
import automata, agregator, changer, viewer;

void main(string[] args) {
    assert(args.length == 4, "Need to pass sizes of automata and number of steps");

    Celler automata = new Automata(to!size_t(args[1]), to!size_t(args[2]));
    Agregator agregator = new RandomAgregator;
    automata.fill(agregator);

    Viewer viewer = new ConsoleViewer;
    viewer.show(automata);

    Changer changer = new LifeChanger;
    for (uint i = 0; i < to!uint(args[3]); ++i) {
        automata.next(changer);
        viewer.show(automata);
    }
}