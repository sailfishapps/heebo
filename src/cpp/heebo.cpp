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

#include <QGuiApplication>
#include "gameview.h"

Q_DECL_EXPORT int main(int argc, char** argv) {
    QGuiApplication app(argc, argv);
    
    GameView view;
#ifdef HARMATTAN
    view.showFullScreen();
#else
    view.show();
#endif

    return app.exec();
}
