#include "playbutton.h"

PlayButton::PlayButton(const QString &start_text, const QString &stop_text, QWidget *parent) :
    Button(start_text, parent), _startText(start_text), _stopText(stop_text), _started(false)
{
    connect(this, SIGNAL(clicked()), this, SLOT(changeState()));
}

void PlayButton::changeState() {
    _started = !_started;
    setText(_started ? _stopText : _startText);
    if (_started) emit timerStart();
    else emit timerStop();
}
