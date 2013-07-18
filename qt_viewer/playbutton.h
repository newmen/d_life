#ifndef PLAYBUTTON_H
#define PLAYBUTTON_H

#include "button.h"

class PlayButton : public Button
{
    Q_OBJECT
public:
    explicit PlayButton(const QString &_startText, const QString &_stopText, QWidget *parent = 0);

signals:
    void timerStart();
    void timerStop();

private slots:
    void changeState();

private:
    QString _startText, _stopText;
    bool _started;
};

#endif // PLAYBUTTON_H
