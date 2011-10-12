#ifndef _GAMEMAP_H_
#define _GAMEMAP_H_

// #include <QTextStream>
#include <QtCore>

//------------------------------------------------------------------------------

class GameMap {
public:
  static GameMap* fromTextStream(QTextStream&, int, int);

  int at(int r, int c) const;

private:
  GameMap(int, int);
  void load(QTextStream&);

  QList< QList<int> > m_map;
  int m_width, m_height;
};

#endif /* _GAMEMAP_H_ */
