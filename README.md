# Life on D

In order to probe the language of D, Conway's Game of Life implemented.

Linking after failed make in qt_viewer dir:

```
cd qt_viewer && make
cd ..
dmd -gc (or -g ???) qt_viewer/*.o \
  agregator.d automata.d celler.d \
  changer.d complete_automata.d main.d \
  -L-L/home/newmen/Qt-4.8.4/lib \
  -L-lQtGui -L-lQtCore -L-lstdc++ \
  -oflife
```
