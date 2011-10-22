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

#include "editorwindow.h"

//------------------------------------------------------------------------------

EditorWindow::EditorWindow() : QMainWindow(), m_mapset(NULL) {
  readSettings();

  setWindowTitle("Heebo level editor");

  createActions();
  createMenus();

  m_tabWidget = new QTabWidget(this);
  setCentralWidget(m_tabWidget);

  loadMapset("../../map.dat");
}

//------------------------------------------------------------------------------

EditorWindow::~EditorWindow() {
  writeSettings();
  m_mapset->save();
}

//------------------------------------------------------------------------------

void EditorWindow::createActions() {
  m_exitAction = new QAction(tr("E&xit"), this);
  m_exitAction->setShortcut(tr("Ctrl+Q"));
  connect(m_exitAction, SIGNAL(triggered()), this, SLOT(exit()));
}

//------------------------------------------------------------------------------

void EditorWindow::createMenus() {
  m_mainMenu = new QMenu(tr("&Editor"), this);
  m_mainMenu->addSeparator();
  m_mainMenu->addAction(m_exitAction);
  menuBar()->addMenu(m_mainMenu);

    /* menu:
  HeeboEditor
  - Open Mapset
  - Save 
  - Save as ...
  - Preferences
  - Exit
  Maps
  - Insert new map
  Help
  - About
  */  
}

//------------------------------------------------------------------------------

void EditorWindow::exit() {
  qApp->exit();
}

//------------------------------------------------------------------------------

void EditorWindow::writeSettings() {
  QSettings s("heebo","editor");
  
  s.beginGroup("MainWindow");
  s.setValue("size", size());
  s.setValue("pos", pos());
  s.endGroup();
}

//------------------------------------------------------------------------------

void EditorWindow::readSettings() {
  QSettings s("heebo","editor");

  s.beginGroup("MainWindow");
  resize(s.value("size", QSize(550, 500)).toSize());
  move(s.value("pos", QPoint(0, 0)).toPoint());
  s.endGroup();
}

//------------------------------------------------------------------------------

void EditorWindow::loadMapset(const QString& fileName) {
  if (m_mapset != NULL) {
    delete m_mapset;
  }

  m_mapset = new GameMapSet(fileName, 0, this);

  qDebug() << "Loaded mapset" << fileName << "with" << m_mapset->numLevels()
           << "levels";

  for (int i=0; i<m_mapset->numLevels(); i++) {
    GameMap* m = m_mapset->map(i);
    MapWidget* mw = new MapWidget(m, this);
    m_tabWidget->addTab(mw, QString("Level %1").arg(i+1));
  }
}
