/*
    Copyright 2018, Mitch Curtis

    This file is part of Slate.

    Slate is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Slate is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Slate. If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

import App 1.0

RangeSlider {
    id: root
    from: -1
    to: 1
    first.value: parameter.varianceLowerBound
    second.value: parameter.varianceUpperBound
    // TODO: remove this when https://github.com/mitchcurtis/slate/issues/45 is fixed
    live: false

    property string displayName
    property TexturedFillParameter parameter

    ToolTip.text: qsTr("Adjusts the lower and upper bounds for random %1 variance").arg(displayName)
    ToolTip.visible: hovered

    function commit() {
        parameter.varianceLowerBound = first.value
        parameter.varianceUpperBound = second.value
    }

    // https://bugreports.qt.io/browse/QTBUG-67311
    first.onValueChanged: parameter.varianceLowerBound = first.value
    second.onValueChanged: parameter.varianceUpperBound = second.value

    ToolTip {
        parent: root.first.handle
        visible: root.first.pressed
        text: root.first.value.toFixed(1)
    }
    ToolTip {
        parent: root.second.handle
        visible: root.second.pressed
        text: root.second.value.toFixed(1)
    }
}