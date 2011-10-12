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
  Q_PROPERTY(bool onLastLevel
             READ onLastLevel);
  
public:
  explicit GameMapSet(const QString& fileName, int initialLevel,
                      QObject* parent=0);
  
  int level() const;
  int setLevel(int l);
  bool onLastLevel() const { return m_level == m_number-1; }

public slots:
  int at(int r, int c) const;

signals:
  void levelChanged();

private:
  void loadMap();

  QString m_fileName;
  
  QList<GameMap*> m_maps;

  int m_width, m_height, m_number;
  int m_level; // current level
};

#endif /* _GAMEMAPSET_H_ */
