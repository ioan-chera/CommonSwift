/*
 CommonSwift library
 Copyright (C) 2018  Ioan Chera

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

import Foundation

/// NSPoint addition
public func + (left: NSPoint, right: NSPoint) -> NSPoint {
    return NSPoint(x: left.x + right.x, y: left.y + right.y)
}

/// NSPoint-NSSize addition => NSPoint again
public func + (left: NSPoint, right: NSSize) -> NSPoint {
    return NSPoint(x: left.x + right.width, y: left.y + right.height)
}
public func + (left: NSSize, right: NSPoint) -> NSPoint {
    return NSPoint(x: left.width + right.x, y: left.height + right.y)
}

/// NSRect-NSPoint addition => NSRect
public func + (left: NSRect, right: NSPoint) -> NSRect {
    return NSRect(origin: left.origin + right, size: left.size)
}
public func + (left: NSPoint, right: NSRect) -> NSRect {
    return NSRect(origin: left + right.origin, size: right.size)
}

/// NSRect-NSSize addition => NSRect
public func + (left: NSRect, right: NSSize) -> NSRect {
    return NSRect(origin: left.origin + right, size: left.size)
}
public func + (left: NSSize, right: NSRect) -> NSRect {
    return NSRect(origin: left + right.origin, size: right.size)
}

/// NSSize-CGFloat division
public func * (left: CGFloat, right: NSSize) -> NSSize {
    return NSSize(width: left * right.width, height: left * right.height)
}
public func * (left: Int, right: NSSize) -> NSSize {
    return CGFloat(left) * right
}
public func / (left: NSSize, right: CGFloat) -> NSSize {
    return NSSize(width: left.width / right, height: left.height / right)
}
public func / (left: NSSize, right: Int) -> NSSize {
    return left / CGFloat(right)
}
