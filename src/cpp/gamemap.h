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

#ifndef _GAMEMAP_H_
#define _GAMEMAP_H_

// #include <QTextStream>
#include <QtCore>

//------------------------------------------------------------------------------

class GameMap {
public:
  static GameMap* fromTextStream(QTextStream&, int, int);

  QChar at(int r, int c) const;

private:
  GameMap(int, int);
  void load(QTextStream&);

  QList< QList<QChar> > m_map;
  int m_width, m_height;
};

#endif /* _GAMEMAP_H_ */
