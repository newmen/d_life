import agregator, changer;

interface Celler {
    void fill(Agregator agr);

    size_t x() const;
    size_t y() const;

    int state(size_t x, size_t y) const;

    void next(Changer changer);
}
