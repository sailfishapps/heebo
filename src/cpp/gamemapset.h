/*
  Copyright 2012 Mats Sjöberg
  
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

#ifndef _GAMEMAPSET_H_
#define _GAMEMAPSET_H_

#include <QtCore>
#include <QObject>

#include "gamemap.h"

class GameMapSet : public QObject {
  Q_OBJECT
  Q_PROPERTY(int level
             READ level
             NOTIFY levelChanged
             WRITE setLevel);
  Q_PROPERTY(int numLevels
             READ numLevels);
  Q_PROPERTY(bool onLastLevel
             READ onLastLevel);
  
public:
  explicit GameMapSet(int width, int height, QObject* parent=0);
  explicit GameMapSet(const QString& fileName, int initialLevel,
                      QObject* parent=0);

  void save(const QString& fileName="");
  
  QString fileName() const { return m_fileName; }
  int level() const;
  int setLevel(int l);
  int numLevels() const { return m_number; }
  bool onLastLevel() const { return m_level == m_number-1; }

  GameMap* newMap(int);
  void removeMap(int);
  void swapMaps(int, int);

  GameMap* map(int l);

public slots:
  QString at(int r, int c) const;
  QString prop(int r, int c) const;

signals:
  void levelChanged();

private:
  void loadMap();

  bool OK(int);

  QString m_fileName;
  
  QList<GameMap*> m_maps;

  int m_width, m_height, m_number;
  int m_level; // current level
};

#endif /* _GAMEMAPSET_H_ */
