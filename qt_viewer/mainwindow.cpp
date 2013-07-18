#include <QtGui>
#include "mainwindow.h"

MainWindow::MainWindow() {
   _renderArea = new RenderArea(this);
   _nextButton = new Button("Next", this);
   _saveButton = new Button("Save", this);
   _restoreButton = new Button("Restore", this);
   _playButton = new PlayButton("Play", "Stop", this);

   connect(_nextButton, SIGNAL(clicked()), _renderArea, SLOT(next()));
   connect(_saveButton, SIGNAL(clicked()), _renderArea, SLOT(save()));
   connect(_restoreButton, SIGNAL(clicked()), _renderArea, SLOT(restore()));
   connect(_playButton, SIGNAL(timerStart()), _renderArea, SLOT(play()));
   connect(_playButton, SIGNAL(timerStop()), _renderArea, SLOT(stop()));

   QHBoxLayout *buttonsLayout = new QHBoxLayout;
   buttonsLayout->addWidget(_nextButton);
   buttonsLayout->addWidget(_saveButton);
   buttonsLayout->addWidget(_restoreButton);
   buttonsLayout->addWidget(_playButton);
   QGroupBox *buttonsGroup = new QGroupBox;
   buttonsGroup->setLayout(buttonsLayout);

   QVBoxLayout *mainLayout = new QVBoxLayout(this);
   mainLayout->addWidget(_renderArea);
   mainLayout->addWidget(buttonsGroup);

   setWindowTitle("Conway's Game of Life");
}

MainWindow::~MainWindow() {
    delete _renderArea;
    delete _nextButton;
    delete _playButton;
}

