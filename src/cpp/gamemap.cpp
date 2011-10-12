#include "gamemap.h"

#include <QDebug>

//------------------------------------------------------------------------------

GameMap::GameMap(int width, int height) :
  m_width(width), m_height(height)
{}

//------------------------------------------------------------------------------

int GameMap::at(int r, int c) const {
  if (r < 0 || r >= m_height || c < 0 || c >=m_width)
    return -1;
  return m_map[r][c];
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

    QList<int> list;
    for (int i=0; i<m_width; i++) {
      QChar ch = line[i];
      if (!ch.isDigit()) {
        qCritical() << "Character" << ch << "on line" << n << "is not a digit.";
        return;
      }
      list.append(ch.digitValue());
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
  
