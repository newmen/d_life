#include <QtGui/QApplication>
#include "mainwindow.h"

int cppmain(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;
    w.show();

    return a.exec();
}
