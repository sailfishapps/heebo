#include "gamemapset.h"

//------------------------------------------------------------------------------

inline uint qHash(const QPoint& p) {
  return qHash(p.x())^qHash(p.y());
}

//------------------------------------------------------------------------------

GameMapSet::GameMapSet(const QString& fileName, int initialLevel,
                       QObject* parent) :
  QObject(parent),
  m_fileName(fileName)
{
  loadMap();
  setLevel(initialLevel);
}

//------------------------------------------------------------------------------

int GameMapSet::level() const {
  return m_level;
}

//------------------------------------------------------------------------------

int GameMapSet::setLevel(int l) {
  if (l != m_level && l >= 0 && l < m_number) {
    m_level = l;
    emit levelChanged();
  }

  return m_level;
}

//------------------------------------------------------------------------------

QString GameMapSet::at(int r, int c) const {
  QChar ch = m_maps[m_level]->at(r,c);
  
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

void GameMapSet::loadMap() {
  QFile fp(m_fileName);

  if (!fp.open(QIODevice::ReadOnly)) {
    qCritical() << "Cannot open map file:" << m_fileName;
    return;
  }

  QTextStream in(&fp);

  int n = 0;
  while (!in.atEnd()) {
    QString line = in.readLine();

    if (line[0] == '#')
      continue;
    
    n++; // count uncommented lines

    bool ok = true;
    if (n==1) 
      m_width = line.toInt(&ok);
    else if (n==2)
      m_height = line.toInt(&ok);
    else if (n==3) {
      m_number = line.toInt(&ok);
      break;
    }
  }
  for (int i=0; i<m_number; i++) {
    GameMap* gm = GameMap::fromTextStream(in, m_width, m_height);
    m_maps.append(gm);
  }
}

//------------------------------------------------------------------------------


