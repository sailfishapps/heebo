/*
  Copyright 2011 Mats Sjöberg
  
  This file is part of the Heebo programme.
  
  Heebo is free software: you can redistribute it and/or modify it
  under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.
  
  Heebo is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
  or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
  License for more details.
  
  You should have received a copy of the GNU General Public License
  along with Heebo.  If not, see <http://www.gnu.org/licenses/>.
*/

#ifndef _MAPWIDGET_H_
#define _MAPWIDGET_H_

#include <QtGui>
#include "cpp/gamemap.h"

class MapWidget : public QGraphicsView {
  Q_OBJECT
public:
  explicit MapWidget(GameMap* map, QWidget* parent=0);

signals:
  void changes();

protected:
  void mouseReleaseEvent(QMouseEvent*);

private:
  void populateScene();

  void drawBlock(int, int);
  void drawBlock(const QPoint& p) { drawBlock(p.x(), p.y()); }

  void updateBorder(int, int);

  QGraphicsScene* m_scene;
  GameMap* m_map;
  QRect m_mapRect;
};

#endif /* _MAPWIDGET_H_ */
