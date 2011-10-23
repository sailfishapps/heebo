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

#include "mapwidget.h"

#include <math.h>

const int block_width = 60;
const int block_height = 60;

//------------------------------------------------------------------------------

MapWidget::MapWidget(GameMap* map, QWidget* parent) :
  QGraphicsView(parent),
  m_map(map)
{
  m_mapRect.setCoords(0, 0, m_map->width()-1, m_map->height()-1);

  m_scene = new QGraphicsScene(this);
  populateScene();
  setScene(m_scene);

  show();
}

//------------------------------------------------------------------------------

void MapWidget::mouseReleaseEvent(QMouseEvent* event) {
  QPointF clickPos = mapToScene(event->pos());
  if (!m_scene->sceneRect().contains(clickPos))
    return;

  QPoint mapPos(floor(clickPos.x() / block_width),
                floor(clickPos.y() / block_height));

  QChar from = m_map->at(mapPos);
  QChar to;
  if (from == 'W')
    to = '0';
  else
    to = 'W';

  m_map->set(mapPos, to);

  for (int dx=-1; dx<= 1; dx++) {
    for (int dy=-1; dy<= 1; dy++) {
      QPoint pt = mapPos + QPoint(dx, dy);
      if (m_mapRect.contains(pt)) {
        updateBorder(pt.x(), pt.y());
        drawBlock(pt);
      }
    }
  }    

  drawBlock(mapPos);

  emit changes();
}

//------------------------------------------------------------------------------

void MapWidget::updateBorder(int x, int y) {
  QChar here = m_map->at(y, x);
  if (here == 'W')
    return;

  bool left  = m_map->at(y, x-1) == 'W';
  bool right = m_map->at(y, x+1) == 'W';
  bool above = m_map->at(y-1, x) == 'W';
  bool below = m_map->at(y+1, x) == 'W';
  
  QChar ch = '0';
  if (left && above && below)
    ch = '<';
  else if (right && above && below)
    ch = '>';
  else if (above && below)
    ch = '-';
  else if (left && right)
    ch = '|';
  else if (left && above) 
    ch = '3';
  else if (left && below)
    ch = '9';
  else if (left)
    ch = '6';
  else if (right && above)
    ch = '1';
  else if (right && below)
    ch = '7';
  else if (right)
    ch = '4';
  else if (above)
    ch = '2';
  else if (below)
    ch = '8';

  m_map->set(y, x, ch);
}

//------------------------------------------------------------------------------

void MapWidget::drawBlock(int i, int j) {
  QList<QGraphicsItem*> oldItems = m_scene->items(i*block_width, j*block_width,
                                                  block_width, block_height,
                                                  Qt::IntersectsItemShape,
                                                  Qt::AscendingOrder);

  // qDebug() << "drawBlock:" << i << j << "old:" << oldItems.size();

  for (int k=0; k<oldItems.size(); k++) {
    m_scene->removeItem(oldItems[k]);
    delete oldItems[k];
  }
  
  QString blockName = m_map->atName(j, i);

  QString fileName = QString(":/images/%1.png").
    arg(blockName == "W" ? "block_wall_1" : "bg");
  
  QGraphicsPixmapItem* pm =
    m_scene->addPixmap(QPixmap(fileName).
                       scaled(block_width, block_height,
                              Qt::IgnoreAspectRatio,
                              Qt::SmoothTransformation));
  pm->setOffset(i*block_width, j*block_height);
  
  if (blockName != "W" && blockName != "0") {
    QString borderFileName = QString(":/images/wb_%1.png").arg(blockName);
    QGraphicsPixmapItem* pm =
      m_scene->addPixmap(QPixmap(borderFileName).
                         scaled(block_width, block_height,
                                Qt::IgnoreAspectRatio,
                                Qt::SmoothTransformation));
    pm->setOffset(i*block_width, j*block_height);
    pm->setZValue(5);
  }
}

//------------------------------------------------------------------------------

void MapWidget::populateScene() {
  for (int j=0; j<m_map->height(); j++) {
    for (int i=0; i<m_map->width(); i++) {
      drawBlock(i, j);
    }
  }
}

