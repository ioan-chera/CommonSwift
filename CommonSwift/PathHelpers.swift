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

//
// Namespace
//
public enum Path {
    //
    // Checks that the URL has the following files, in a case insensitive way, and not as folders
    //
    public static func findSubpaths(url: URL, fileNames: [String]) throws -> [String: URL] {
        let path = url.path
        let files = try FileManager.default.contentsOfDirectory(atPath: path)

        var result: [String:URL] = [:]

        for file in files {
            let fileLower = file.lowercased()
            for variant in fileNames {
                if fileLower.caseInsensitiveCompare(variant) == .orderedSame {
                    result[variant] = url.appendingPathComponent(file)
                    break
                }
            }
        }
        return result
    }
}
