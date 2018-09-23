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

///
/// Extensions to the Data type
///
public extension Data {

    ///
    /// Transpose, assuming it represents a matrix
    ///
    public func transpose(originalWidth: Int) -> Data {
        let originalHeight = count / originalWidth
        var result = Data()
        for x in 0 ..< originalWidth {
            for y in 0 ..< originalHeight {
                result.append(self[y * originalWidth + x])
            }
        }
        return result
    }
}