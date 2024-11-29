import Foundation

//Loading ASCII art from a file
func loadAsciiArt(from fileName: String) -> String {
    if let path = Bundle.main.path(forResource: fileName, ofType: "txt") {
        if let content = try? String(contentsOfFile: path, encoding: .utf8) {
            return content
        }
    }
    return "Error: Could not load file \(fileName)"
}

//Printing the ASCII art from the files
print(loadAsciiArt(from: "sat"))

print(loadAsciiArt(from: "earth"))

print(loadAsciiArt(from: "moon"))

// Source:
// https://asciiart.website/index.php?art=animals/aardvarks
