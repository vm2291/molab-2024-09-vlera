

//Function that prints the letter "V"
func printV() {
    print("@       @")
    print(" @     @ ")
    print("  @   @  ")
    print("   @ @   ")
    print("    @    ")
}

//Function that prints the letter "M"
func printM() {
    print("@            @")
    print("@ @   @ @")
    print("@  @ @  @")
    print("@    @     @")
    print("@            @")
}


printV()

// Printing an empty line for spacing
print("")

printM()

func generateRandomEmojiPattern(count: Int) {
    let emojis = ["😀", "🐱", "🌟", "🍕", "🎉", "🚀"]

    var pattern = ""
    for i in 1...count {
        let randomIndex = Int.random(in: 0..<emojis.count)
        pattern += emojis[randomIndex]
    }

    print(pattern)
}


generateRandomEmojiPattern(count: 5)

