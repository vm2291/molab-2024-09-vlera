import Foundation

// Function that prints the letter "V" (My name initial)
func printV() {
    print("@       @")
    print(" @     @ ")
    print("  @   @  ")
    print("   @ @   ")
    print("    @    ")
}

// Function that prints the letter "M"(Lastname initial)
func printM() {
    print("@       @")
    print("@ @   @ @")
    print("@  @ @  @")
    print("@   @   @")
    print("@       @")
}

// Creating a line with spaces and "&"
func createLine(spaces: Int, symbols: Int) -> String {
    let spaceString = String(repeating: " ", count: spaces)
    let symbolString = String(repeating: "&", count: symbols)
    return spaceString + symbolString + spaceString
}

// Making a diamond shape
func drawDiamond(size: Int) {
    // First half of the diamond
    for i in 0..<size {
        let spaces = size - i - 1
        let symbols = i * 2 + 1
        print(createLine(spaces: spaces, symbols: symbols))
    }
    
    // Second half of the diamond
    for i in (0..<size-1).reversed() {
        let spaces = size - i - 1
        let symbols = i * 2 + 1
        print(createLine(spaces: spaces, symbols: symbols))
    }
}





//Making a random emoji pattern
func generateRandomEmojiPattern(count: Int) {
    let emojis = ["😀", "🐱", "🌟", "🍕", "🎉", "🚀"]
    var pattern = ""
    for _ in 1...count {
        let randomIndex = Int.random(in: 0..<emojis.count)
        pattern += emojis[randomIndex]
    }
    print(pattern)
}

// Calling all the functions
printV()
printM()
print("")
drawDiamond(size: 5)
print("")
generateRandomEmojiPattern(count: 5)

