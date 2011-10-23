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

const int board_width  = 6;
const int board_height = 9;

const QString titleName = "Heebo level editor";
const QString mapsetFileFilter = "Mapset files (*.dat)";

//------------------------------------------------------------------------------

EditorWindow::EditorWindow(const QString& fileName) :
  QMainWindow(),
  m_mapset(NULL),
  changes(false)
{
  readSettings();

  createActions();
  createMenus();

  m_tabWidget = new QTabWidget(this);
  setCentralWidget(m_tabWidget);

  loadMapset(fileName);
}

//------------------------------------------------------------------------------

EditorWindow::~EditorWindow() {
  writeSettings();
}

//------------------------------------------------------------------------------

void EditorWindow::createActions() {
  m_newAction = new QAction(tr("&New mapset"), this);
  // m_newAction->setShortcut(tr("Ctrl+"));
  connect(m_newAction, SIGNAL(triggered()), this, SLOT(newMapset()));

  m_openAction = new QAction(tr("&Open..."), this);
  m_openAction->setShortcut(tr("Ctrl+O"));
  connect(m_openAction, SIGNAL(triggered()), this, SLOT(openMapset()));

  m_saveAction = new QAction(tr("&Save"), this);
  m_saveAction->setShortcut(tr("Ctrl+S"));
  connect(m_saveAction, SIGNAL(triggered()), this, SLOT(saveMapset()));

  m_saveAsAction = new QAction(tr("Save &As..."), this);
  m_saveAsAction->setShortcut(tr("Shift+Ctrl+S"));
  connect(m_saveAsAction, SIGNAL(triggered()), this, SLOT(saveAsMapset()));

  m_exitAction = new QAction(tr("E&xit"), this);
  m_exitAction->setShortcut(tr("Ctrl+Q"));
  connect(m_exitAction, SIGNAL(triggered()), this, SLOT(exit()));

  m_newLevelAction = new QAction(tr("&New level"), this);
  m_newLevelAction->setShortcut(tr("Ctrl+N"));
  connect(m_newLevelAction, SIGNAL(triggered()), this, SLOT(newLevel()));

  m_removeLevelAction = new QAction(tr("&Remove level"), this);
  // m_removeLevelAction->setShortcut(tr("Ctrl+"));
  connect(m_removeLevelAction, SIGNAL(triggered()), this, SLOT(removeLevel()));

  m_moveLeftAction = new QAction(tr("Move level &left"), this);
  m_moveLeftAction->setShortcut(tr("Ctrl+Left"));
  connect(m_moveLeftAction, SIGNAL(triggered()), this, SLOT(moveLeft()));

  m_moveRightAction = new QAction(tr("Move level &left"), this);
  m_moveRightAction->setShortcut(tr("Ctrl+Right"));
  connect(m_moveRightAction, SIGNAL(triggered()), this, SLOT(moveRight()));
}

//------------------------------------------------------------------------------

void EditorWindow::createMenus() {
  m_mainMenu = new QMenu(tr("&Editor"), this);
  m_mainMenu->addAction(m_newAction);
  m_mainMenu->addAction(m_openAction);
  m_mainMenu->addAction(m_saveAction);
  m_mainMenu->addAction(m_saveAsAction);
  m_mainMenu->addSeparator();
  m_mainMenu->addAction(m_exitAction);
  menuBar()->addMenu(m_mainMenu);

  m_levelMenu = new QMenu(tr("&Levels"), this);
  m_levelMenu->addAction(m_newLevelAction);
  m_levelMenu->addAction(m_removeLevelAction);
  m_levelMenu->addAction(m_moveLeftAction);
  m_levelMenu->addAction(m_moveRightAction);
  menuBar()->addMenu(m_levelMenu);
}

//------------------------------------------------------------------------------

void EditorWindow::newMapset() {
  loadMapset();
}

//------------------------------------------------------------------------------

void EditorWindow::openMapset() {
  QString fileName =
    QFileDialog::getOpenFileName(this, tr("Open mapset"), QString(),
                                 mapsetFileFilter);
  loadMapset(fileName);
}

//------------------------------------------------------------------------------

void EditorWindow::loadMapset(const QString& fileName) {
  if (m_mapset != NULL) {
    if (changes) {
      int ret = saveModsQuery();
    
      if (ret == QMessageBox::Save)
        saveMapset();
      else if (ret == QMessageBox::Cancel)
        return;
    }

    delete m_mapset;
  }

  if (fileName.isEmpty()) 
    m_mapset = new GameMapSet(board_width, board_height);
  else
    m_mapset = new GameMapSet(fileName, 0, this);

  // Remove old tabs and widgets
  for (int i=m_tabWidget->count()-1; i>=0; i--) {
    QWidget* w = m_tabWidget->widget(i);
    m_tabWidget->removeTab(i);
    delete w;
  }

  // Add new tabs and widgets for new levels
  for (int i=0; i<m_mapset->numLevels(); i++) {
    GameMap* m = m_mapset->map(i);
    MapWidget* mw = new MapWidget(m, this);
    connect(mw, SIGNAL(changes()), this, SLOT(onChanges()));
    m_tabWidget->addTab(mw, mapLabel(i));
  }

  if (fileName.isEmpty())
    newLevel();

  setChanges(false);
}

//------------------------------------------------------------------------------

void EditorWindow::onChanges() {
  setChanges(true);
}

//------------------------------------------------------------------------------

void EditorWindow::setChanges(bool b) {
  changes = b;
  updateTitle();
}

//------------------------------------------------------------------------------

void EditorWindow::updateTitle() {
  QString currentFile = m_mapset ? m_mapset->fileName() : "";
  if (currentFile.isEmpty())
    currentFile = "Untitled";

  if (changes)
    currentFile = "*"+currentFile;
      
  setWindowTitle(currentFile+" - "+titleName);
}

//------------------------------------------------------------------------------

void EditorWindow::saveMapset() {
  if (m_mapset->fileName().isEmpty())
    saveAsMapset();
  else
    m_mapset->save();
}

//------------------------------------------------------------------------------

void EditorWindow::saveAsMapset() {
  QString fileName =
    QFileDialog::getSaveFileName(this, tr("Save mapset"), QString(),
                                 mapsetFileFilter);
  m_mapset->save(fileName);
}

//------------------------------------------------------------------------------

int EditorWindow::saveModsQuery() {
  QMessageBox msgBox;
  msgBox.setWindowTitle(titleName);
  msgBox.setText("The mapset has been modified.");
  msgBox.setInformativeText("Do you want to save your changes?");
  msgBox.setStandardButtons(QMessageBox::Save | QMessageBox::Discard | QMessageBox::Cancel);
  msgBox.setDefaultButton(QMessageBox::Save);
  return msgBox.exec();
}

//------------------------------------------------------------------------------

void EditorWindow::exit() {
  if (changes) {
    int ret = saveModsQuery();
    
    if (ret == QMessageBox::Save)
      saveMapset();
    else if (ret == QMessageBox::Cancel)
      return;
  }

  qApp->exit();
}

//------------------------------------------------------------------------------

QString EditorWindow::mapLabel(int index) {
  return QString("# %1").arg(index+1);
}

//------------------------------------------------------------------------------

void EditorWindow::updateTabLabels(int from) {
  for (int i=from; i<m_tabWidget->count(); i++)
    m_tabWidget->setTabText(i, mapLabel(i));
}

//------------------------------------------------------------------------------

void EditorWindow::newLevel() {
  int index = m_tabWidget->currentIndex()+1;

  GameMap* m = m_mapset->newMap(index);
  MapWidget* mw = new MapWidget(m, this);
  connect(mw, SIGNAL(changes()), this, SLOT(onChanges()));
  m_tabWidget->insertTab(index, mw, mapLabel(index));

  updateTabLabels(index+1);

  m_tabWidget->setCurrentIndex(index);

  setChanges(true);
}

//------------------------------------------------------------------------------

void EditorWindow::removeLevel() {
  int index = m_tabWidget->currentIndex();

  m_mapset->removeMap(index);
  m_tabWidget->removeTab(index);

  updateTabLabels(index);

  setChanges(true);
}

//------------------------------------------------------------------------------

void EditorWindow::swapMaps(int i, int j) {
  if (i == j) {
    qDebug() << "swapMaps:" << i << j << "makes no sense.";
    return;
  }

  if (i > j)
    qSwap(i, j);

  m_mapset->swapMaps(i, j);

  MapWidget* mw_i = qobject_cast<MapWidget*>(m_tabWidget->widget(i));
  MapWidget* mw_j = qobject_cast<MapWidget*>(m_tabWidget->widget(j));

  m_tabWidget->removeTab(j);
  m_tabWidget->removeTab(i);

  m_tabWidget->insertTab(i, mw_j, mapLabel(i));
  m_tabWidget->insertTab(j, mw_i, mapLabel(j));

  updateTabLabels(qMin(i, j));

  setChanges(true);
}

//------------------------------------------------------------------------------

void EditorWindow::moveLeft() {
  int index = m_tabWidget->currentIndex();
  if (index <= 0)
    return;

  swapMaps(index-1, index);  
  m_tabWidget->setCurrentIndex(index-1);

  setChanges(true);
}

//------------------------------------------------------------------------------

void EditorWindow::moveRight() {
  int index = m_tabWidget->currentIndex();
  if (index < 0 || index >= m_tabWidget->count()-1)
    return;

  swapMaps(index, index+1);
  m_tabWidget->setCurrentIndex(index+1);

  setChanges(true);
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

