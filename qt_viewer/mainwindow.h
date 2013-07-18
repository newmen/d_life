#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QWidget>
#include "renderarea.h"
#include "playbutton.h"

class MainWindow : public QWidget
{
    Q_OBJECT

public:
     explicit MainWindow();
     ~MainWindow();

private:
     RenderArea *_renderArea;
     Button *_nextButton;
     Button *_saveButton;
     Button *_restoreButton;
     PlayButton *_playButton;
};

#endif // MAINWINDOW_H
