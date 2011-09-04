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
  // rootContext()->setContextProperty("inboxMessageModel", inboxMessageModel);
  rootContext()->setContextProperty("gameview", this);

  setSource(QUrl("./qml/main.qml"));

  // QObject* rootObj = rootObject();
  // connect(rootObj, SIGNAL(openUrl(QString)), this, SLOT(openUrl(QString)));
  //  QMetaObject::invokeMethod(rootObject(), "Jewel.startNewGame");
}

