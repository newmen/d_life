#ifndef AUTOMATAINTERFACE_H
#define AUTOMATAINTERFACE_H

class AutomataInterface {
public:
    virtual void next() = 0;

    virtual void save() = 0;
    virtual void restore() = 0;
    virtual void zerofile() = 0;

    virtual void invert(unsigned long x, unsigned long y) = 0;

    virtual int state(unsigned long x, unsigned long y) const = 0;

    virtual unsigned long x() const = 0;
    virtual unsigned long y() const = 0;
};

AutomataInterface *createAutomata(unsigned int x, unsigned int y);

#endif // AUTOMATAINTERFACE_H
