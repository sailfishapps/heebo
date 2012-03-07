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

#ifndef _GAMEMAP_H_
#define _GAMEMAP_H_

#include <QtCore>

//------------------------------------------------------------------------------

class GameMap {
public:
  static GameMap* fromTextStream(QTextStream&, int, int);
  static GameMap* emptyMap(int, int);

  QChar at(int r, int c) const;
  QChar at(const QPoint& p) const;
  QString atName(int r, int c) const;

  QString propertyName(int r, int c) const;
  QString propertyName(const QPoint& p) const;
  void clearProperty(const QPoint& p);
  void setProperty(const QPoint& p, const QString& s);

  void set(int r, int c, QChar ch);
  void set(const QPoint& p, QChar ch);

  int width() const { return m_width; }
  int height() const { return m_height; }

  void save(QTextStream&) const;

private:
  GameMap(int, int);
  void load(QTextStream&);
  bool OK(int r, int c) const;
  bool OK(const QPoint& p) const;

  QList< QList<QChar> > m_map;
  QHash<QPoint, QString> m_prop;
  int m_width, m_height;
};

inline uint qHash(const QPoint& p) {
  return qHash(p.x())^qHash(p.y());
}

#endif /* _GAMEMAP_H_ */
