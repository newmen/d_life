extern(C++) int cppmain(int argc, char **argv);

int main() {
    import core.runtime;
    return cppmain(Runtime.cArgs.argc, Runtime.cArgs.argv);
}
