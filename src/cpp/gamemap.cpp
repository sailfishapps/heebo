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

#include "gamemap.h"

#include <QDebug>

//------------------------------------------------------------------------------

GameMap::GameMap(int width, int height) :
  m_width(width), m_height(height)
{}

//------------------------------------------------------------------------------

QChar GameMap::at(int r, int c) const {
  if (r < 0 || r >= m_height || c < 0 || c >=m_width)
    return ' ';
  return m_map[r][c];
}

//------------------------------------------------------------------------------

QString GameMap::atName(int r, int c) const {
  QChar ch = at(r, c);
    
  if (ch == '|') 
    return "updown";
  else if (ch == '-')
    return "leftright";
  else if (ch == '<')
    return "deadend_left";
  else if (ch == '>')
    return "deadend_right";
  else
    return ch;
}

//------------------------------------------------------------------------------

void GameMap::load(QTextStream& in) {
  int n = 0;
  while (n < m_height && !in.atEnd()) {
    QString line = in.readLine();

    if (line[0] == '#')
      continue;

    n++; // count uncommented lines

    if (line.length() != m_width) {
      qCritical() << "Line length:" << line.length() << "!=" << m_width;
      return;
    }

    QList<QChar> list;
    for (int i=0; i<m_width; i++) {
      QChar ch = line[i];
      if (!QString("012346789W|-<>").contains(ch)) {
        qCritical() << "Character" << ch << "on line" << n
                    << "is not an allowed map character.";
        return;
      }
      list.append(ch);
    }
    m_map.append(list);
  }      
}

//------------------------------------------------------------------------------

GameMap* GameMap::fromTextStream(QTextStream& in, int w, int h) {
  GameMap* gm = new GameMap(w,h);
  gm->load(in);
  return gm;
}
  
