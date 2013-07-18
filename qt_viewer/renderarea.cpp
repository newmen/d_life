#include <QtGui>
#include "renderarea.h"

#define SIDE_LENGTH 15

RenderArea::RenderArea(QWidget* parent) : QWidget(parent)
{
    _cellular = createAutomata(55, 34);
    _timer = new QTimer(this);

    connect(_timer, SIGNAL(timeout()), this, SLOT(next()));
}

RenderArea::~RenderArea() {
    delete _timer;
    delete _cellular;
}

void RenderArea::next() {
    _cellular->next();
    update();
}

void RenderArea::play() {
    _timer->start(100);
}

void RenderArea::stop() {
    _timer->stop();
}

void RenderArea::save() {
    _cellular->save();
}

void RenderArea::restore() {
    _cellular->restore();
    update();
}

int RenderArea::getCoordinate(int cell_index) const {
    return cell_index * SIDE_LENGTH + SIDE_LENGTH / 2;
}

int RenderArea::getIndex(int coordinate) const {
    return (coordinate - SIDE_LENGTH / 2) / SIDE_LENGTH;
}

QSize RenderArea::minimumSizeHint() const
{
    return QSize(SIDE_LENGTH * (_cellular->x() + 1), SIDE_LENGTH * (_cellular->y() + 1));
}

void RenderArea::mousePressEvent(QMouseEvent* event) {
    _cellular->invert(getIndex(event->x()), getIndex(event->y()));
    update();
}

void RenderArea::paintEvent(QPaintEvent*)
{
    QRect rect(0, 0, SIDE_LENGTH, SIDE_LENGTH);

    QBrush brush_state0(Qt::white);
    QBrush brush_state1(Qt::darkGreen);
    QPen pen(Qt::black);

    QPainter painter(this);
    painter.setRenderHint(QPainter::Antialiasing, true);
    painter.setPen(pen);

    for (unsigned long x = 0; x < _cellular->x(); ++x) {
        for (unsigned long y = 0; y < _cellular->y(); ++y) {
            if (_cellular->state(x, y) == 0) {
                painter.setBrush(brush_state0);
            } else {
                painter.setBrush(brush_state1);
            }
        
            painter.save();
            painter.translate(getCoordinate(x), getCoordinate(y));
            painter.drawRect(rect);
            painter.restore();
        }
    }

    painter.setRenderHint(QPainter::Antialiasing, false);
}
