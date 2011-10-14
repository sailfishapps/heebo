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
  
