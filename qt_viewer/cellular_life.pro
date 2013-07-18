#-------------------------------------------------
#
# Project created by QtCreator 2011-09-29T14:44:02
#
#-------------------------------------------------

QT       += core gui

TARGET = cellular_life
TEMPLATE = app

LIBS += /home/newmen/projects/d/life/obj/*.o

SOURCES += main.cpp\
        mainwindow.cpp \
    renderarea.cpp \
    button.cpp \
    playbutton.cpp

HEADERS  += mainwindow.h \
    renderarea.h \
    button.h \
    playbutton.h \
    automatainterface.h

FORMS    +=
