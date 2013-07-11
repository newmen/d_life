import std.stdio;
import celler;

interface Viewer {
    void show(Celler celler) const;
}

class ConsoleViewer : Viewer {
    override void show(Celler celler) const {
        for (size_t y = 0; y < celler.y(); ++y) {
            for (size_t x = 0; x < celler.x(); ++x) {
                write((celler.state(x, y) == 0) ? '.' : '0');
            }
            write("\n");
        }

        for (int i = 0; i < 10; i++) writeln;
    }
}