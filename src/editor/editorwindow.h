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

#ifndef _EDITORWINDOW_H_
#define _EDITORWINDOW_H_

#include <QtGui>

#include "mapwidget.h"

#include "cpp/gamemapset.h"
#include "cpp/gamemap.h"

class EditorWindow : public QMainWindow {
  Q_OBJECT

public:
  EditorWindow(const QString& fileName="");
  ~EditorWindow();

private slots:
  void newMapset();
  void openMapset();
  void saveMapset();
  void saveAsMapset();
  void exit();
  
  void newLevel();
  void removeLevel();
  void moveLeft();
  void moveRight();

  void onChanges();
  
private:
  void loadMapset(const QString& fileName="");
  void updateTabLabels(int from=0);
  void swapMaps(int, int);
  QString mapLabel(int);
  void setChanges(bool);
  
  int saveModsQuery();
  void updateTitle();

  GameMapSet* m_mapset;
  bool changes;

  // UI stuff
  void readSettings();
  void writeSettings();
  
  void createActions();
  void createMenus();

  QMenu* m_mainMenu;
  QAction* m_newAction;
  QAction* m_openAction;
  QAction* m_saveAction;
  QAction* m_saveAsAction;
  QAction* m_exitAction;

  QMenu* m_levelMenu;
  QAction* m_newLevelAction;
  QAction* m_removeLevelAction;
  QAction* m_moveLeftAction;
  QAction* m_moveRightAction;

  QTabWidget* m_tabWidget;
};

#endif /* _EDITORWINDOW_H_ */
