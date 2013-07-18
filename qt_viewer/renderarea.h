#ifndef RENDERAREA_H
#define RENDERAREA_H

#include <QWidget>
#include "automatainterface.h"

class RenderArea : public QWidget
{
    Q_OBJECT
public:
    explicit RenderArea(QWidget *parent = 0);
    virtual ~RenderArea();

    QSize minimumSizeHint() const;

//signals:
public slots:
    void next();
    void play();
    void stop();

    void save();
    void restore();

protected:
    int getCoordinate(int cell_index) const;
    int getIndex(int coordinate) const;

    void mousePressEvent (QMouseEvent *event);
    void paintEvent(QPaintEvent *event);

private:
    AutomataInterface *_cellular;
    QTimer *_timer;
};

#endif // RENDERAREA_H
