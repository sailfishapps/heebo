/*
  Copyright 2011 Mats Sjöberg
  
  This file is part of the QMLJewels programme.

  QMLJewels is free software: you can redistribute it and/or modify it
  under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  QMLJewels is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with QMLJewels.  If not, see <http://www.gnu.org/licenses/>.
*/

#include "gameview.h"

#include <QDeclarativeEngine>
#include <QGraphicsObject>

//------------------------------------------------------------------------------

GameView::GameView(QWidget* parent) : QDeclarativeView(parent) {
  rootContext()->setContextProperty("gameview", this);
#ifdef HARMATTAN
  rootContext()->setContextProperty("platform", "harmattan");
  setSource(QUrl("qrc:///qml/main_harmattan.qml"));
#else
  rootContext()->setContextProperty("platform", "desktop");
  setSource(QUrl("qrc:///qml/main.qml"));
#endif
}

